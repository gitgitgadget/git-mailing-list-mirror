From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [GSoC15] Interested in contributing to git
Date: Tue, 03 Mar 2015 19:14:30 +0100
Message-ID: <vpq8ufe9ce1.fsf@anie.imag.fr>
References: <CACRoPnSrjysUhC77LXVjy5VJxFFPoiRuhD7pMab_8T2Pua_T+A@mail.gmail.com>
	<vpqbnkagiie.fsf@anie.imag.fr>
	<CACRoPnTAFXBRR3uv8gL8tGfYNo_ygNutJZuPm=Sq0Ae3obF-kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 19:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSrL8-00036o-UW
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 19:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756931AbbCCSOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 13:14:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48912 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556AbbCCSOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 13:14:37 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t23IESFg018825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 19:14:28 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23IEUTF020330;
	Tue, 3 Mar 2015 19:14:30 +0100
In-Reply-To: <CACRoPnTAFXBRR3uv8gL8tGfYNo_ygNutJZuPm=Sq0Ae3obF-kw@mail.gmail.com>
	(Paul Tan's message of "Wed, 4 Mar 2015 02:08:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 03 Mar 2015 19:14:28 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23IESFg018825
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426011272.46548@IhOdA2WLraFQUAbpj+XGag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264675>

Paul Tan <pyokagan@gmail.com> writes:

> Also, quick question, where should the XDG tests go for
> git-credential-store? I see t1306-xdg-files.sh and
> t0302-credentials-store.sh.

I think both could make sense, but it will probably be more natural in
t1306-xdg-files.sh. See what the other tests took like.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
