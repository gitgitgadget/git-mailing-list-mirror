From: "Albert Krawczyk" <albert@burgmann.anu.edu.au>
Subject: RE: Development Environment Setup
Date: Mon, 17 May 2010 15:40:06 +1000
Message-ID: <00f901caf583$67ba1650$372e42f0$@burgmann.anu.edu.au>
References: <00b801caf560$6d07be50$47173af0$@burgmann.anu.edu.au> <12452_1274073815_4BF0D2D7_12452_439_1_4BF0D2CC.8090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "'Gabriel Filion'" <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 07:40:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODt3r-0008Hm-AL
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 07:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0EQFkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 01:40:13 -0400
Received: from anumail9.anu.edu.au ([130.56.64.135]:48912 "EHLO
	anumail9.anu.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab0EQFkL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 01:40:11 -0400
Received: from mailout2.anu.edu.au (mailout2.anu.edu.au [130.56.64.233])
	by anumail9.anu.edu.au (8.14.3/8.14.3) with ESMTP id o4H5e6nF017240;
	Mon, 17 May 2010 15:40:06 +1000 (EST)
Received: from mailout2.anu.edu.au (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 02AF59E833D;
	Mon, 17 May 2010 15:40:06 +1000 (EST)
Received: from smtphost.anu.edu.au (ds2.anu.edu.au [130.56.64.54])
	by mailout2.anu.edu.au (Postfix) with ESMTP id 96B669E82B6;
	Mon, 17 May 2010 15:40:05 +1000 (EST)
Received: from AlbertDesktop (burg237222.anu.edu.au [150.203.237.222])
	by smtphost.anu.edu.au (8.14.3/8.14.3) with SMTP id o4H5e5CG005406
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 17 May 2010 15:40:05 +1000 (EST)
In-Reply-To: <12452_1274073815_4BF0D2D7_12452_439_1_4BF0D2CC.8090605@gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJ2P453lfh2QYcabg9Jubl709d99gFZ2dEykPO4meA=
Content-Language: en-au
X-PMX-Version: 5.5.9.395186, Antispam-Engine: 2.7.2.376379, Antispam-Data: 2010.5.17.53022 internal
X-PMX-Outbound: anu.edu.au
X-PMX-Info: from-anu
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1200_1299 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, FORGED_MUA_OUTLOOK 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __OUTLOOK_MUA 0, __OUTLOOK_MUA_1 0, __SANE_MSGID 0, __TO_MALFORMED_2 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT_MS_GENERIC 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147208>

Hi Gabriel,

I probably expressed myself incorrectly. 

What IDE do people use to develop / debug Git.

Albert 

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Gabriel Filion
Sent: Monday, 17 May 2010 3:23 PM
To: Albert Krawczyk
Cc: git@vger.kernel.org
Subject: Re: Development Environment Setup

On 2010-05-16 21:29, Albert Krawczyk wrote:
> Hi,
> 
> I'm curious, what is the recommended / typical setup for Git development?
> 
> Do people use IDEs? If they do what are they? 
> 
> I'm looking to do dev on Ubuntu. 
> 

Git has a couple of solution up its sleeves. Depending on which kind of IDE you're typically using, you can use the right plugin or interface for your needs.

If you like Eclipse as an IDE, EGit will be for you.

have a look at this list:

https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Editors_and_IDE_integration

And, higher up on the page, you can find descriptions for graphical interfaces for git.

--
Gabriel Filion
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
