From: JM Ibanez <jm@orangeandbronze.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 06:01:13 +0800
Organization: Orange & Bronze Software Labs, Ltd. Co.
Message-ID: <87odbkyuvq.fsf@adler.orangeandbronze.com>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
	<65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
	<200801162251.54219.jnareb@gmail.com>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 23:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFco5-0000DN-VY
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 23:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbYAQWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756490AbYAQWBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 17:01:25 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:8594 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755603AbYAQWBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 17:01:23 -0500
Received: by hs-out-2122.google.com with SMTP id 54so612554hsz.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2008 14:01:23 -0800 (PST)
Received: by 10.142.111.14 with SMTP id j14mr1650036wfc.22.1200607282047;
        Thu, 17 Jan 2008 14:01:22 -0800 (PST)
Received: from adler.orangeandbronze.com ( [61.28.150.66])
        by mx.google.com with ESMTPS id i40sm8738514wxd.25.2008.01.17.14.01.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Jan 2008 14:01:21 -0800 (PST)
Jabber-ID: jmibanez@gmail.com
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUBAQEPDw8aGhoiIiIy
 MjJGRkZaWlp0dHScnJy+vr7R0dHb29vn5+fx8fH29vb///+JzcfYAAAAAWJLR0QAiAUdSAAAAAlw
 SFlzAAAewgAAHsIBbtB1PgAAAi5JREFUOMul1E9o01AYAPAvUQ87JV+3gcemrYi32q7oQRC7gtWD
 OLs6jx5svQhDCk0GggeHTaWgt/ZF5gRlkHZePCg0lTE8SWvnUXHU3QRxyYYryrCpr4PlT81OeyE5
 fD/y5b0v73vQP2DA4aBcWvMEQjJvPKAiF66nhSsrw9CNFnOIo3PyMKRj6cmoEJt/sOiGrhBHFpnx
 qdScG64FAODEWCJ9ddoFOyhQGJ3wx6eCj51wOoDAABNmghHfrAP+BC4gD8AzvI8Nn3HAr0xUQJoL
 WIbng+dtmB58AXiajd7MfQu6ftgfNCFrvbENdpwC4j5sWXFm73HMSrVqxfdmMG7Be2BxIpGYDIIw
 mPSYPSuYEUVRKmTjg2ViyIYtpSITeuUEnkdfzFGSWr1aJwoppwLI+C46QFWVOlluatrbCJ5MOqCp
 1bTyrUsfO8bn1MK3NRt8Txsv8Wi+pOumpLUcAMebD7NK651h/LintlZsyEaUQkjStI7595XaWrQg
 BDhyF2Ck1NNN42tz1gIBjswMinGj0zfM9RZn/yiAyzcp3NH7Rr/93YZtZM69pmV6plMxNhzrSLEL
 XxCZtkHjq5wDfkvt9Rd4qm2YfZNzbp/eB13/ebth0Ew9N6ib+uYSrYhufnJv0eTyUvpRodrobHBu
 2CGiRHJniw0YboOKmE1hUnzODcNuRVJIPgP/txohspoPcx49SHfDPOfRnLtyUfZ79nmt+oTzhCKB
 A04GONwh8w9J0EXBeLkUcQAAAABJRU5ErkJggg==
In-Reply-To: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 17 Jan 2008 08\:43\:25 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70931>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> So the whole "but they _look_ the same" argument is just total BS. In just 
> about all character encodings there has always been unique and different 
> "characters" that _look_ the same on screen, and it has never really made 
> them actually *be* the same, and it has never been a valid argument for 
> them being considered the same.

With the exception of Unicode. If you check the standard, two Unicode
codepoints (i.e. the numeric value that gets stored on disk) *can* map
to the same character, hence they are the same. They don't just look the
same, they are the same character -- even if the codepoints are
different (i.e. precomposed vs. decomposed characters). In fact, part of
the Unicode standard deals with that. (Technically, Unicode calls it
equivalence, but what the hey).

In other words, Unicode treats e.g. both U+0065 and U+00E9 as
fundamentally the same character. This comes even more into play in such
alphabets as Hangul (Korean) and the Japanese Kana.


-- 
JM Ibanez
Software Architect
Orange & Bronze Software Labs, Ltd. Co.

jm@orangeandbronze.com
http://software.orangeandbronze.com/
