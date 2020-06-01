package com.project.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.service.BoardService;
import com.project.service.ReplyService;
import com.project.vo.BoardVO;
import com.project.vo.ReplyVO;
import com.project.vo.SearchCriteria;
 	
@Controller //컨트롤러 어노케이션 선언
@RequestMapping("/board/*") //리퀘스트 맵핑 선언("/board/전체값")
public class BoardController { //퍼블릭 클레스 컨트롤러 선언

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class); //로그 찍기
	
	@Inject//의존성 주입
	BoardService service;
	
	@Inject //의존성 주입
	ReplyService replyService;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/board/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("writeView");	//로그찍기
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/board/write", method = RequestMethod.POST) //작성하고 저장해야되니 post의 값으로보내줌 //단순히 값을 가져오는것이 아니라서 get이 아닌 post로 작성한 것
	public String write(BoardVO boardVO) throws Exception{
		logger.info("write");
		service.write(boardVO); //service에 write보내는대 boardVO에 값을 담는다.
		
		return "redirect:/board/list"; //리턴할때는 board/list의 값으로 리턴을 시켜준다.
	}

	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET) 
	public String list(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{//리스트메소드에 model 객체에 파라미터값을 넣고 보내는데
		logger.info("list"); //로그를 찍어준다.														  //@ModelAttribute는 속성값을 주입하거나 바인딜 될때에 사용된다. 
																								  //SearchCriteria를 사용하는데, SearchCriteria가 Criteria를 상속했기떄문에 원하는 값을 가져올 수 있다.
		service.list(model, scri);// list에 model과 scri의 값을 보내준다.
		
		return "board/list"; //조회하고 리턴값을 준다.
		}
	
	// 게시판 상세보기
	@RequestMapping(value = "/readView", method = RequestMethod.GET) //post가 아닌 get을 씀 단순 보여주기 용도이기 때문에
	public String read(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model, @RequestParam int bno, ReplyVO vo) throws Exception{// read 메소드 선언 쓸 객체들 선언 																											//bno에 담아서 값을 받아온다 @RequestParam은 값을 받아온다.
		logger.info("read");//로그 찍기
		
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno()); 
		model.addAttribute("replyList", replyList);
		service.read(boardVO, scri, model, bno);

		return "board/readView";
	}
	
	// 게시판 수정뷰
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception{
		logger.info("updateView");
		
		model.addAttribute("update", service.read(boardVO, scri, model, boardVO.getBno()));
		model.addAttribute("scri", scri);
		
		return "board/updateView";
	}
	
	// 게시판 수정
	@RequestMapping(value = "/update", method = {RequestMethod.GET,RequestMethod.POST}) //get,post를 같이쓴 방식 이럴때는 get방식의 단점을 보안하기 위헤 RedirectAttributes를 씀, RedirectAttributes는 post방식처럼 보일수는 있겟지만 session을 이용한 다
	public String update(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("update");
		
		service.update(boardVO, scri, rttr);

		return "redirect:/board/list";
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = {RequestMethod.GET,RequestMethod.POST}) //위외 동일
	public String delete(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception{
		logger.info("delete");
		service.delete(boardVO.getBno(), boardVO, scri, rttr);
		
		return "redirect:/board/list";
		}
	
	//댓글 작성
	@RequestMapping(value="/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
		replyService.writeReply(vo, scri, rttr);
		
		return "redirect:/board/readView"; 	
		}
		
	//댓글 수정 GET
	@RequestMapping(value="/replyUpdateView", method = RequestMethod.GET)
	public String replyUpdateView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");
		replyService.replyUpdateView(vo, scri, model);
		
		return "board/replyUpdateView";
	}
	
	//댓글 수정 POST
	@RequestMapping(value="/replyUpdate", method = RequestMethod.POST)
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr, int rno) throws Exception {
		logger.info("reply Write");
		
		replyService.updateReply(vo, scri, rttr);
		replyService.selectReply(rno);
		
		return "redirect:/board/readView";
	}
	
	//댓글 삭제 GET
	@RequestMapping(value="/replyDeleteView", method = RequestMethod.GET)
	public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		logger.info("reply Write");	
		replyService.replyDeleteView(vo, scri, model);

		return "board/replyDeleteView";
	}
	
	//댓글 삭제
	@RequestMapping(value="/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		logger.info("reply Write");
		replyService.deleteReply(vo, scri, rttr);
		
		return "redirect:/board/readView";
	}
}