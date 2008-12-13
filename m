From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 17:44:07 +0100
Message-ID: <4943E657.9040204@gmx.ch>
References: <200812131624.57618.Resul-Cetin@gmx.net> <fcaeb9bf0812130746l38a12f37wde26f31d5fa0d2a2@mail.gmail.com> <200812131714.05472.Resul-Cetin@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Resul Cetin <Resul-Cetin@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	gentoo-scm@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 17:45:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBXcY-000324-0z
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 17:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbYLMQoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbYLMQoM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 11:44:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:52524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750820AbYLMQoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 11:44:11 -0500
Received: (qmail invoked by alias); 13 Dec 2008 16:44:08 -0000
Received: from 92-37.79-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.79.37.92]
  by mail.gmx.net (mp013) with SMTP; 13 Dec 2008 17:44:08 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX18m2oMiF6Qmyuy3wanVUc3BIWDZUdEUenoszaxbET
	bXo6GGpJlJpC6a
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
In-Reply-To: <200812131714.05472.Resul-Cetin@gmx.net>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.8100000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103005>

Resul Cetin wrote:
> That would be a workaround but it doesn't explain why git.kernel.org deliveres 
> torvalds repository without any notable counting and compressing time.

If I remember right, git.kernel.org is a quite beefy machine.  But
then again it has a lot more traffic too.  It might be interesting
to know what machine you're on, compared to git.kernel.org.

jlh
