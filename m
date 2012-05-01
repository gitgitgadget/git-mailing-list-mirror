From: David Ebbo <david.ebbo@gmail.com>
Subject: Re: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 1 May 2012 10:53:19 -0700 (PDT)
Message-ID: <12419089.206.1335894799764.JavaMail.geo-discussion-forums@pbcgj9>
References: <20120501084048.GA21904@sigill.intra.peff.net>
 <20120501084307.GC4998@sigill.intra.peff.net>
 <20120501093501.GB22633@ecki.lan>
 <20120501093719.GA7538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_205_16267860.1335894799764"
Cc: Clemens Buchacher <drizzd@aon.at>, Junio C Hamano <gitster@pobox.com>, 
	dfowler <davidfowl@gmail.com>, git@vger.kernel.org, 
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: msysgit@googlegroups.com
X-From: msysgit+bncCIuuisXIFhCRxoD9BBoEcNyoCQ@googlegroups.com Tue May 01 19:53:23 2012
Return-path: <msysgit+bncCIuuisXIFhCRxoD9BBoEcNyoCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCIuuisXIFhCRxoD9BBoEcNyoCQ@googlegroups.com>)
	id 1SPHGM-0005nX-S1
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 19:53:23 +0200
Received: by qcsc2 with SMTP id c2sf4393811qcs.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=j3ET9fAGHldZZApjN+JnBt8BIAAW2aDHQPGh8t6B2yY=;
        b=nfK+0yc9VPe3b7dftKw52cJDVEf+bs7s5kaoEQMHPpQJ+sInFEjX08cqX3QtyjT4Ow
         JChDI/fTlWRSWmuvhXB0B0hGOJS+fBlDWoSPuC2o/cXgTNpq7wdof1U+k6YftEIh5iWQ
         Y2ZLukEa1FEc7Hl/lu9GFlinlKNRTNTivWyeU=
Received: by 10.68.195.33 with SMTP id ib1mr580275pbc.18.1335894801380;
        Tue, 01 May 2012 10:53:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.75.45 with SMTP id z13ls12592330pbv.7.gmail; Tue, 01 May
 2012 10:53:20 -0700 (PDT)
Received: by 10.68.216.104 with SMTP id op8mr1138167pbc.1.1335894800507;
        Tue, 01 May 2012 10:53:20 -0700 (PDT)
In-Reply-To: <20120501093719.GA7538@sigill.intra.peff.net>
X-Original-Sender: david.ebbo@gmail.com
X-Original-Authentication-Results: ls.google.com; spf=pass (google.com: domain of
 david.ebbo@gmail.com designates internal as permitted sender)
 smtp.mail=david.ebbo@gmail.com; dkim=pass
 header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196713>

------=_Part_205_16267860.1335894799764
Content-Type: text/plain; charset=ISO-8859-1

Many thanks to Jeff King and others to help track this one down! 

David

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

------=_Part_205_16267860.1335894799764
Content-Type: text/html; charset=ISO-8859-1

Many thanks to Jeff King and others to help track this one down!&nbsp;<div><br></div><div>David</div>

<p></p>

-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href="https://github.com/msysgit/msysgit/wiki">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href="http://groups.google.com/group/msysgit?hl=en_US?hl=en">http://groups.google.com/group/msysgit?hl=en_US?hl=en</a><br />

------=_Part_205_16267860.1335894799764--
