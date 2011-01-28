From: redstun <redstun@gmail.com>
Subject: add command clean to git help
Date: Fri, 28 Jan 2011 17:43:08 +0800
Message-ID: <AANLkTimnqoNudu66Y+a2R_ttk9ghw7Z-eL1AtcpK=4HB@mail.gmail.com>
References: <AANLkTinsY-53nq5-2-4M8B_=BwymHC4UQWU9feez8KZc@mail.gmail.com> <AANLkTikNx-yi5FsK3vVv7MRCxNfEQOM+O5a8EssdpCN3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 10:43:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pikre-0002jO-UC
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 10:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab1A1Jna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 04:43:30 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab1A1Jn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 04:43:29 -0500
Received: by bwz15 with SMTP id 15so3036001bwz.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=TOc1w6ZqvecyFrv1iOOWck0oe7tq3lvLTlZlNItONFg=;
        b=Sz3WEKrLxbwS+aMoEtaUZSIT7giYhNac6b1nuwV98xIw2SOL7kQ+Y4sblyDsGDNqx8
         cH1h4D+hbd0ktxWIIsM4GiUd9GD5ddImDA0Iv0zCWu2o24N9D2TtsRFX0//LrZ3wg7wV
         97MujAp99IB54KZsSdunLBZ6Y1cuzUrZD9VOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=jojDsTbPGYbT6i36pobcxrtWG/RUKxRyffri8qWwVQnJy4RhazZmJB15UynGyRInOW
         xZPqIoDpHxmx0OXWswGrGZ74wJwHBfxk8XsUVj1x00a0oEp956Aj0KZOAxWlNtsFy91T
         jN72kmjC0iU1vrPof3ssSYvSdKprXuZkme250=
Received: by 10.204.98.65 with SMTP id p1mr2223213bkn.198.1296207808254; Fri,
 28 Jan 2011 01:43:28 -0800 (PST)
Received: by 10.204.103.8 with HTTP; Fri, 28 Jan 2011 01:43:08 -0800 (PST)
In-Reply-To: <AANLkTikNx-yi5FsK3vVv7MRCxNfEQOM+O5a8EssdpCN3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165606>

Just realized in git help the command clean is not mentioned, yet

#git --version
git version 1.7.3.3
