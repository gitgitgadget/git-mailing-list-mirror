From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Git does not use GIT_* envirnment vars?
Date: Fri, 27 May 2005 01:54:59 -0500
Message-ID: <200505270155.00180.dtor_core@ameritech.net>
References: <200505270109.44302.dtor_core@ameritech.net> <7vmzqh17y9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 08:55:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbYiy-00087j-Ty
	for gcvg-git@gmane.org; Fri, 27 May 2005 08:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVE0Gz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 02:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVE0Gz2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 02:55:28 -0400
Received: from smtp815.mail.sc5.yahoo.com ([66.163.170.1]:58720 "HELO
	smtp815.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261911AbVE0GzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 02:55:16 -0400
Received: from unknown (HELO mail.corenet.homeip.net) (dtor?core@ameritech.net@68.21.93.207 with login)
  by smtp815.mail.sc5.yahoo.com with SMTP; 27 May 2005 06:55:01 -0000
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vmzqh17y9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Friday 27 May 2005 01:47, Junio C Hamano wrote:
> I am baffled.  If you are a bash user, what does "type --all"
> tells you?  The only explanation I can think of is that you
> might have leftover old git-* installation somewhere on your
> PATH.

*sigh* Exactly. I forgot to uninstall cogito rpm after pulling
the latest tree and they got mixed up. Dammit, I just wasted 3
hours because of my own stupidity :(

Thank you for your help. 

-- 
Dmitry
