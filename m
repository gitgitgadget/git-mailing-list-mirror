From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 19:58:55 +0100
Message-ID: <4F14736F.6040903@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de> <4F1404E7.9040805@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1h?= =?UTF-8?B?cnTDrW4gTmlldG8=?= 
	<cmn@elego.de>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:59:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmrlo-0006WV-6b
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab2APS67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:58:59 -0500
Received: from dotforward.de ([178.63.102.138]:43328 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755679Ab2APS65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 13:58:57 -0500
Received: from dsl01.212.114.235.128.ip-pool.nefkom.net ([212.114.235.128] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1Rmrlf-0004xd-O8; Mon, 16 Jan 2012 19:58:55 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4F1404E7.9040805@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188642>

Great, I have the same file with an equal name twice in my repository
(with 'git ls-files').

How stupid! Git, go learn file names.

I've read (and seen) bad things about Git and Windows, and I knew the
Great Failure Day would eventually come. And I've read that Mercurial
would be better suitable for Windows. You don't know anything about
that, do you?

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
