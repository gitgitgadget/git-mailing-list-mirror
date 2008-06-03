From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git remote rename, why dosen't it exists?
Date: Tue, 03 Jun 2008 15:27:25 +0200
Message-ID: <vpq8wxmsl6q.fsf@bauges.imag.fr>
References: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 15:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Wa0-0003gb-MQ
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYFCN2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYFCN2n
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:28:43 -0400
Received: from imag.imag.fr ([129.88.30.1]:53391 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbYFCN2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:28:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m53DRVkE006153
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Jun 2008 15:27:32 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K3WXt-00046o-MH; Tue, 03 Jun 2008 15:27:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K3WXt-0001gl-K3; Tue, 03 Jun 2008 15:27:25 +0200
In-Reply-To: <1212497390.30731.3.camel@omicron.ep.petrobras.com.br> (Victor Bogado da Silva Lins's message of "Tue\, 03 Jun 2008 09\:49\:50 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 03 Jun 2008 15:27:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83655>

Victor Bogado da Silva Lins <victor@bogado.net> writes:

> Well, that's about it, I need to rename my remotes. Mainly to move the
> origin to another repository and I miss the feature. Since many time
> there is a reason for a missing feature, I fought that maybe I should
> ask here, before nosing around the sources... :)

I think editing .git/config to change the name of the remote would do
it.

-- 
Matthieu
