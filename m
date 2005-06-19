From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.6
Date: Sun, 19 Jun 2005 12:58:12 -0700 (PDT)
Message-ID: <20050619195812.66959.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 21:53:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk5qN-0008OK-36
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 21:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVFST6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 15:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFST6Q
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 15:58:16 -0400
Received: from web26309.mail.ukl.yahoo.com ([217.146.176.20]:52338 "HELO
	web26309.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261304AbVFST6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 15:58:13 -0400
Received: (qmail 66961 invoked by uid 60001); 19 Jun 2005 19:58:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6YibRZW0KLDM7X7N1Mws3iEM/EJPDhTZS7KwaxFAeuvbOHmdSYWz3ncvQRaW6moeYfc9e2o22lwev+gLIZzqtRBLiQ/IvZ8rSJAG+4drF75NMx+jyMfs+7ct1HJgepewGno6O7l33xGX5IfEQk1jbEQ9bUISXiT4SooOwEwzX48=  ;
Received: from [151.38.101.189] by web26309.mail.ukl.yahoo.com via HTTP; Sun, 19 Jun 2005 12:58:12 PDT
To: Ingo Molnar <mingo@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>* Ingo Molnar <mingo@elte.hu> wrote:
>
>>works fine here and is nice and fast, but there are a few minor visual 
>>glitches:
>
>
>one more thing: for the annotated output it would be nicer to have 
>fixed-width fonts to display code. For commit messages the current 
>output is fine, but code is much more readable in fixed-width output.
>
>	Ingo
>

Next release will use Courier 10 for all annotated output, I know from my tree it works.
The only concern is about box with no courier font installed, I don't know if this can be
a problem.

Marco



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
