From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH --no-flowed] http-push: refactor request url creation
Date: Fri, 30 Jan 2009 18:17:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901301816410.3586@pacific.mpi-cbg.de>
References: <49831755.60405@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSx0R-0006qm-0T
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 18:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbZA3RQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 12:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbZA3RQt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 12:16:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:58793 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751100AbZA3RQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 12:16:48 -0500
Received: (qmail invoked by alias); 30 Jan 2009 17:16:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 30 Jan 2009 18:16:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191kV98ddx1WaLSGPFXNsyhL+gHWQBjBvhiNObmBI
	OavQLmaaZN1bXD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49831755.60405@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107854>

Hi,

On Fri, 30 Jan 2009, Tay Ray Chuan wrote:

> +static void append_remote_object_url(struct strbuf *buf, const char *url, const char *hex, int only_two_digit_prefix)

I seem to remember that I mentioned that this line is too long.

Ciao,
Dscho
