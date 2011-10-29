From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: sparse checkout using exclusions
Date: Sat, 29 Oct 2011 11:16:38 +0530
Message-ID: <CALkWK0=X4O9jBbx_ZDXbtnDCmTb9fHbm13Z-pqTNBooA0Z=c0g@mail.gmail.com>
References: <4EAB4632.5080101@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Sat Oct 29 07:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RK1lA-0004bx-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 29 Oct 2011 07:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886Ab1J2FrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Oct 2011 01:47:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32888 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1J2FrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2011 01:47:00 -0400
Received: by wwe6 with SMTP id 6so6717745wwe.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JU5GU8MvINPCIpOaIJmLcHyMlvY5zxcMouw7Y8p2gXU=;
        b=oha9VkaZY1uXgUfQRos2dlO1DFP9NsIRZV1PmA2IGBd/WpI7y1sf26LoPxWM1bFOSF
         CeyA6+nv3C6Fqo35cT7qv3ib11qpzZrw4mmgyENSi5zBRRvwijdxZXVFo6ct4xhFE6Sh
         IFX2JumxnlSzEtulHE1ZGrzczKT4TpYYmYsZQ=
Received: by 10.216.139.133 with SMTP id c5mr451805wej.25.1319867219081; Fri,
 28 Oct 2011 22:46:59 -0700 (PDT)
Received: by 10.216.52.197 with HTTP; Fri, 28 Oct 2011 22:46:38 -0700 (PDT)
In-Reply-To: <4EAB4632.5080101@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184448>

Hi Eric,

Eric Raible writes:
> Might it make sense for the example in git-read-tree.html to be
> updated to include the leading slash?

This issue was fixed in 5e821231 (git-read-tree.txt: update sparse
checkout examples, 2011-09-26).

Cheers.

-- Ram
