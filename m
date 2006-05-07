From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Unresolved issues #2
Date: Sun, 07 May 2006 13:38:16 +0200
Organization: At home
Message-ID: <e3km6q$f7p$1@sea.gmane.org>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org> <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org> <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org> <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE> <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org> <7vvesirh0q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de> <7vy7xekwbs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 07 13:38:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fchab-0004O4-4I
	for gcvg-git@gmane.org; Sun, 07 May 2006 13:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEGLiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 07:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWEGLiL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 07:38:11 -0400
Received: from main.gmane.org ([80.91.229.2]:49831 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932123AbWEGLiK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 07:38:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FchaS-0004MM-8o
	for git@vger.kernel.org; Sun, 07 May 2006 13:38:08 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 13:38:08 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 13:38:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19700>

Junio C Hamano wrote:

>             char *value; /* "existence" bool may have NULL,
>                           * otherwise probably a string "= value"
>                           */

Probably " = value" to preserve whitespace (e.g. justify on equal sign in
hand crafted config file).

-- 
Jakub Narebski
Warsaw, Poland
