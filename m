From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: building git on Solaris
Date: Tue, 7 Sep 2010 21:42:20 +0000
Message-ID: <AANLkTikvy-wUB-RFLegp7KJa_srqh97nLC03bdZDmru=@mail.gmail.com>
References: <4C86A86B.1030107@bio.umass.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Chris Hoogendyk <hoogendyk@bio.umass.edu>
X-From: git-owner@vger.kernel.org Tue Sep 07 23:42:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot5vu-0002xL-Ta
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 23:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab0IGVmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 17:42:22 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40773 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0IGVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 17:42:21 -0400
Received: by yxp4 with SMTP id 4so2040684yxp.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/zkEa+eLYWNRHTQP+RSjLjuVJfmNUJn4urqxfUfr1IU=;
        b=w84apO4x/l1UW2UQEBAsqYtisRuMHBmd/i5u6vMHb5PNlqX2CTVWpBiirTRchcBCjN
         Xz27SJ5rfR07yhOKeqysVEm46EQoxZeTofaVkE4Yn/1mRLjNq4Uw3cHRW0tleQpXY/2V
         7Mx9oIRfGV1OqaROFz8J5SPM1KumNwYnZ9vHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w4unLGZkkoW3yMKQGhv2Hzbs0RGzr5zEq2de9MlxmSL3dkH4bOwlHqAdvqPrKPXsHR
         dy+IaDBVWOpPnFdVJxkSIDtTXcn5wgFoBdrEZW62HnoJPMojvyHpSnO6IKXGYNHgKNB1
         TqqVfqi//TXoNRYl5CuKQ+4PSgiqHbQK2A5Ok=
Received: by 10.150.204.4 with SMTP id b4mr717169ybg.132.1283895740907; Tue,
 07 Sep 2010 14:42:20 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 7 Sep 2010 14:42:20 -0700 (PDT)
In-Reply-To: <4C86A86B.1030107@bio.umass.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155746>

On Tue, Sep 7, 2010 at 21:02, Chris Hoogendyk <hoogendyk@bio.umass.edu> wrote:

> Does anyone have any guidance or clues as to where I should look from here?
> Or how to fix this?

Call make as gmake?
