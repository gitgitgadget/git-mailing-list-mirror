From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: merge renamed files/directories?
Date: Tue, 06 May 2008 19:32:23 +0300
Message-ID: <48208817.4060005@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org> <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com> <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org> <20080506154709.GF6918@mit.edu> <alpine.LFD.1.10.0805060851470.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Steven Grimm <koreth@midwinter.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtQ79-000644-9Q
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760270AbYEFQdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755279AbYEFQdC
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:33:02 -0400
Received: from smtp102.biz.mail.re2.yahoo.com ([68.142.229.216]:25265 "HELO
	smtp102.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759572AbYEFQdA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 12:33:00 -0400
Received: (qmail 69658 invoked from network); 6 May 2008 16:32:58 -0000
Received: from unknown (HELO ?192.168.1.9?) (ittayd@tikalk.com@84.108.89.36 with plain)
  by smtp102.biz.mail.re2.yahoo.com with SMTP; 6 May 2008 16:32:55 -0000
X-YMail-OSG: 00Q0Z7IVM1mFSdos6F5YGCVPFsnuFc9fGtakCbs2AC9mfTlL59kjOa0BRmIEVl3Mjn_TJQK9Wov4hTxuI2TxhXX2FDvzNBPkWXwI_HMkSP_uUdAvGTce5zCy22OxJeDsvJtQdzN1zTfp_1k2w0bNiwON
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.LFD.1.10.0805060851470.32269@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81367>



Linus Torvalds wrote:
>
>  - If they are hard to understand and see, and *unexpected*. The SCM
>    should explain what is going on, and explain why a conflict happens 
>    (and that may perhaps mean after-the fact! I love "gitk --merge" 
>    exactly because it tends to be very good at explaining what was going 
>    on!).
>
>   
So does git tell me what is going on with directory renames? Or should I 
just discover them when I try to compile (assuming that when the old 
directory name appears it will even get compiled, and that the file in 
it is something that gets compiled)

And no, it's not a common problem, but I don't like the fact that a 
merge conflict happens and the SCM doesn't tell me about it.

-- 
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
