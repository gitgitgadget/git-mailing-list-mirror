From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale
 list
Date: Tue, 1 Dec 2009 09:35:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912010934120.4985@pacific.mpi-cbg.de>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:30:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFO8L-0001hr-OM
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 09:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbZLAIam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 03:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZLAIam
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 03:30:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:51001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752063AbZLAIam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 03:30:42 -0500
Received: (qmail invoked by alias); 01 Dec 2009 08:30:47 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 01 Dec 2009 09:30:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xex8hwpZxJziJCmdtqspcyrWOr5FehqFPi/dG26
	IvV7mE49XhOrzO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134178>

Hi,

On Tue, 1 Dec 2009, Bert Wesarg wrote:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

Thanks.  I trust you ran the test suite with valgrind just to make sure?

Ciao,
Dscho
