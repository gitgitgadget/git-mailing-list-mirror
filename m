From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #04; Tue, 11)
Date: Tue, 11 Jun 2013 18:24:25 -0500
Message-ID: <CAMP44s0MmiyWX95HGh52FiQ46n2BB_Onzt-71dYYJCyYZHoHFQ@mail.gmail.com>
References: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 01:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmXvT-0007ae-5u
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 01:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999Ab3FKXY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 19:24:27 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:49026 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3FKXY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 19:24:26 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so7429378lab.18
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=v97qm777Fbn5VXp3j3RfloXbS+0kDmD++cjpNdJG2bM=;
        b=Vwik0d1C7t8ZmCsZWEOpBmUcWZ4HNM5A9V/vKoqIpe4MW78LCHisIrgTfITYjPtcBG
         tC3a6mEhO89tWfQNT/CrW9vTg5McaNfNMEZuj1JTD75LKyqbKqvHKhaaGkm2g714aAwL
         MZsExwkmhwe7nzg9Nl8gtxlkriOT8ifmhly/cCs5VEXXstT+LsVzZIhV3xIKlSURjXP6
         x49Ak+IFTDIvPWuOVQNwBtZ5aIDQPEMuKbtjS4Fe5P3P/rdoxM6vLcEwdkIDJmF4VQDX
         CnRUAvOaxeLEojqVj0G/LLCa4y7mhDOMynned1VeS6AAKG3PFYcoPgmEShd6Ko6CPVb0
         lvAQ==
X-Received: by 10.152.22.73 with SMTP id b9mr8506706laf.36.1370993065176; Tue,
 11 Jun 2013 16:24:25 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 16:24:25 -0700 (PDT)
In-Reply-To: <7vwqq05laf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227576>

On Tue, Jun 11, 2013 at 5:34 PM, Junio C Hamano <gitster@pobox.com> wrote:

> * fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
>  - remote-helpers: add exec-path links
>  - remote-helpers: allow direct test execution
>  - remote-helpers: rename tests
>  - remote-helpers: generate scripts
>
>  I do not particularly think the second from the bottom is a good
>  change, but it takes the remainder of the series hostage.
>
>  Waiting for a reroll.

Waiting for a reroll? This is the first time I hear you are not going
to merge these.

You say actions have consequences... well, you are right, you can stop
waiting for a reroll.

-- 
Felipe Contreras
