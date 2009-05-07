From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: Re: [ANNOUNCE] GIT 1.6.3
Date: Thu, 7 May 2009 09:58:37 -0500
Message-ID: <bbd12f0f0905070758q697f11fck259db4a0207d0aa7@mail.gmail.com>
References: <7vmy9ps820.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 16:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M253n-00056m-NO
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 16:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbZEGO6k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbZEGO6k
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 10:58:40 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:62172 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbZEGO6j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 10:58:39 -0400
Received: by bwz22 with SMTP id 22so826430bwz.37
        for <git@vger.kernel.org>; Thu, 07 May 2009 07:58:37 -0700 (PDT)
Received: by 10.204.58.9 with SMTP id e9mr2508055bkh.15.1241708317850; Thu, 07 
	May 2009 07:58:37 -0700 (PDT)
In-Reply-To: <7vmy9ps820.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118483>

On Thu, May 7, 2009 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> With the next major release, "git push" into a branch that is
> currently checked out will be refused by default. =A0You can choose
> what should happen upon such a push by setting the configuration
> variable receive.denyCurrentBranch in the receiving repository.
>

I want to make sure I understand how this will work.  Could you
describe the simplest set of steps necessary to get into this
situation where the push would be refused?

Thanks for your help.



Jeff

--=20
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
=46ind The Cause ~ Find The Cure
http://www.autismspeaks.org/
