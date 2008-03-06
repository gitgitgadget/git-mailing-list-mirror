From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [RFC] git add -a
Date: Thu, 6 Mar 2008 11:46:00 +0100
Message-ID: <200803061146.00500.barra_cuda@katamail.com>
References: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?iso-8859-1?q?Marc-Andr=E9?= Lureau" <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 11:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXDT0-0005Ok-6u
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 11:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbYCFKgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 05:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755688AbYCFKgM
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 05:36:12 -0500
Received: from smtp.katamail.com ([62.149.157.154]:53296 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755682AbYCFKgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 05:36:11 -0500
Received: (qmail 20122 invoked by uid 89); 6 Mar 2008 10:35:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host53-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.53)
  by smtp1-pc with SMTP; 6 Mar 2008 10:35:47 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <e29894ca0803060223p6de78b1br1aab956c2c99fc1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76362>

On Thursday 06 March 2008, Marc-Andr=E9 Lureau wrote:
> What about "git add -a" ? I am in a situation where I'd like it=20

There's "git add -u". It should do what you want.
