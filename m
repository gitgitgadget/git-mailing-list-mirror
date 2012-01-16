From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Mon, 16 Jan 2012 22:20:42 +0100
Message-ID: <4F1494AA.1000004@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de> <4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de> <4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de> <20120116190956.GA13802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 22:21:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmtzA-0004E9-ES
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab2APVUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 16:20:51 -0500
Received: from dotforward.de ([178.63.102.138]:53061 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755938Ab2APVUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 16:20:50 -0500
Received: from dsl01.212.114.235.128.ip-pool.nefkom.net ([212.114.235.128] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1Rmtyt-0008Md-TQ; Mon, 16 Jan 2012 22:20:44 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120116190956.GA13802@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188656>

On 16.01.2012 20:09 CE(S)T, Jeff King wrote:
> What is the output of "git config core.ignorecase" in your repository?

None, i.e. an empty line.

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
