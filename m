From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC][PATCH] git-send-email: added support for S/MIME
Date: Tue, 4 Jan 2011 20:36:36 +0100
Message-ID: <201101042036.36208.trast@student.ethz.ch>
References: <1294156930-21367-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Roberto Sassu <roberto.sassu@polito.it>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:36:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCgY-0006y5-7C
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab1ADTgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:36:38 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:51447 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab1ADTgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:36:37 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:35:55 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:36:36 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1294156930-21367-1-git-send-email-roberto.sassu@polito.it>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164515>

Roberto Sassu wrote:
> The script git-send-email.perl has been modified in order to add support
> for messages with S/MIME format.

Does git-am need symmetric support to decode the message?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
