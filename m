From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH] MSVC: link dynamically to the CRT
Date: Wed, 30 Apr 2014 22:17:33 +0200
Organization: <)><
Message-ID: <20140430201733.GB21870@camelia.ucw.cz>
References: <20140429102509.GA16706@camelia.ucw.cz> <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 22:17:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfawm-0001Ir-Gt
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 22:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963AbaD3URg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 16:17:36 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46784 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758836AbaD3URf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 16:17:35 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 6C06C1C00F9;
	Wed, 30 Apr 2014 22:17:34 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UKHY5T025103;
	Wed, 30 Apr 2014 22:17:34 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UKHXLm025102;
	Wed, 30 Apr 2014 22:17:33 +0200
Content-Disposition: inline
In-Reply-To: <xmqqa9b2fyve.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247773>

Hello Junio,

On Wed, Apr 30, 2014 at 11:36:37AM -0700, Junio C Hamano wrote:
> like I do not have to ask "does this look ok?" question when seeing
> a patch from Erik or J6t, is it unnecessary for me to do so for a
> patch from you?

it _is_ necessary to ask, as I'm just a newcomer who has (fortunately)
almost no experience with Windows.

But I will try to point out iif it "has been in msysgit for x years".
That fact can be taken as an implicite ack from msysgit community.

Stepan
