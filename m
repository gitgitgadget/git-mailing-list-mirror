From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: User-wide ignore list
Date: Thu, 15 Feb 2007 11:20:24 +0100
Message-ID: <vpq4ppnvi1j.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdjS-0002hj-Bc
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965776AbXBOKUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965778AbXBOKUu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:20:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:44941 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965776AbXBOKUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:20:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l1FAKPwT013972
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 15 Feb 2007 11:20:25 +0100 (CET)
Received: from olympe.imag.fr ([129.88.43.60])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHdiy-0003ug-E4
	for git@vger.kernel.org; Thu, 15 Feb 2007 11:20:24 +0100
Received: from moy by olympe.imag.fr with local (Exim 4.50)
	id 1HHdiy-0004Rg-Bl
	for git@vger.kernel.org; Thu, 15 Feb 2007 11:20:24 +0100
Mail-Followup-To: git <git@vger.kernel.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 15 Feb 2007 11:20:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39809>

Hi,

Is there a way to have a per-user ignore list in git?

I'd like to ignore once and for all the backup files of my editor
(*~), which are not necessarily relevant to a project, but definitely
relevant for me regardless of the project.

Thanks,

-- 
Matthieu
