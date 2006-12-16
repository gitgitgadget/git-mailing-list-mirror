X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: svn versus git
Date: Sat, 16 Dec 2006 07:26:58 +0700
Message-ID: <fcaeb9bf0612151626k1442daa9ib2bf90f7563c4835@mail.gmail.com>
References: <200612132200.41420.andyparkins@gmail.com>
	 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
	 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
	 <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612150726o40527552l8b3564ddcc3adb94@mail.gmail.com>
	 <Pine.LNX.4.63.0612152115000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0612152117390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64ccomdc.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0612151736470.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 00:27:08 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LXNsPByS0BPUbW5oPFBhQBHc6DG3J16PLBrFwFe0qDYYzVOsfQmoDHrhWplinVrs6DOtVVns4UlN/nvpP9riTPJMtHu+d4osbWOdkvJphosinXgf02+iw0svajAuaXmMs/GQhclOAtqQ+E60a1lJ/v0VrGW/yTW66qmC3g+zfT8=
In-Reply-To: <Pine.LNX.4.64.0612151736470.18171@xanadu.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34579>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvNOJ-0007HS-Ok for gcvg-git@gmane.org; Sat, 16 Dec
 2006 01:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030472AbWLPA1A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWLPA1A
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 19:27:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:62459 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030472AbWLPA07 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 19:26:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so961729uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 16:26:58 -0800 (PST)
Received: by 10.78.136.9 with SMTP id j9mr512797hud.1166228818110; Fri, 15
 Dec 2006 16:26:58 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Fri, 15 Dec 2006 16:26:58 -0800 (PST)
To: "Nicolas Pitre" <nico@cam.org>
Sender: git-owner@vger.kernel.org

On 12/16/06, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 15 Dec 2006, Junio C Hamano wrote:
>
> >  * we add 'git ls' command to give Porcelain-ish access to
> >    ls-tree and ls-files.
>
> That seems the most sensible to me.

I agree.

-- 
