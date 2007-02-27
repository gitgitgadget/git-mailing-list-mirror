From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny reflog has missing space
Date: Tue, 27 Feb 2007 16:59:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271659260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702271529.13258.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 17:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4kG-0004ft-UV
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 17:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbXB0QAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 11:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbXB0QAA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 11:00:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:40302 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932691AbXB0P76 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:59:58 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:59:57 -0000
X-Provags-ID: V01U2FsdGVkX19FKiR/QGVF/pYbx+A7XbQfWzWSgdVdB36ALP3Mna
	5DeA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702271529.13258.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40753>

Hi,

On Tue, 27 Feb 2007, Andy Parkins wrote:

> Is this normal?  "git-reflog show" works fine in both cases.

Yes, because Junio made me change the code to not barf on a missing space.

Thanks Junio,
Dscho
