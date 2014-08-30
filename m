From: dev <dev@cor0.com>
Subject: Re: make install fails because GNU tar needed
Date: Sat, 30 Aug 2014 11:26:42 -0400 (EDT)
Message-ID: <1977769443.25625.1409412402646.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
References: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <20140828145056.GA26855@peff.net> <502287515.26012.1409238536022.JavaMail.vpopmail@webmail2.networksolutionsemail.com> <vpqwq9sy6s8.fsf@anie.imag.fr>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:26:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNkYK-0002b8-Hq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 17:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbaH3P0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 11:26:53 -0400
Received: from atl4mhob01.myregisteredsite.com ([209.17.115.39]:47552 "EHLO
	atl4mhob01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751476AbaH3P0w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 11:26:52 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7UFQgOB013846;
	Sat, 30 Aug 2014 11:26:42 -0400
In-Reply-To: <vpqwq9sy6s8.fsf@anie.imag.fr>
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256254>



On August 28, 2014 at 11:26 AM Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> dev <dev@cor0.com> writes:
>
> > Actually I found a file called GIT-BUILD-OPTIONS :
>
> That's a generated file (not included by the Makefile, but by some
> shell
> scripts later), don't edit it. Use config.mak for your build
> configuration.

good to know .. thanks.
