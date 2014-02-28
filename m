From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: `git stash pop` UX Problem
Date: Fri, 28 Feb 2014 20:39:32 +0100
Message-ID: <vpqy50vt4az.fsf@anie.imag.fr>
References: <1lho9x8.1qh70zkp477M%lists@haller-berlin.de>
	<vpqmwhexidi.fsf@anie.imag.fr> <85fvn40ws9.fsf@stephe-leake.org>
	<CANUGeEZTeqBpf0VP4gCG9iN=v20U4axxoSjX9JbLPp_ppX3QiA@mail.gmail.com>
	<851tynz2yg.fsf@stephe-leake.org> <87mwhb1azp.fsf@fencepost.gnu.org>
	<85r46n168a.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 20:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTHj-00063W-T5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbaB1Tjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:39:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59150 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbaB1Tjq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:39:46 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1SJdUsP009735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 28 Feb 2014 20:39:31 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1SJdWDq024071;
	Fri, 28 Feb 2014 20:39:32 +0100
In-Reply-To: <85r46n168a.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 11:45:25 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 28 Feb 2014 20:39:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1SJdUsP009735
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394221171.75191@ZsxyOJwHWuw5FC/MrGEinQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243008>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> I was not aware that the git system could support more than one version
> of a file in one branch. 

The index only. The history itself does not.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
