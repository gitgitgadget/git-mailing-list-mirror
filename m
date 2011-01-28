From: redstun <redstun@gmail.com>
Subject: Re: add command clean to git help
Date: Fri, 28 Jan 2011 22:49:03 +0800
Message-ID: <AANLkTimg4dWHJ-L2iGmy41d3WLDMxRyoLbgaogwN+P=a@mail.gmail.com>
References: <AANLkTinsY-53nq5-2-4M8B_=BwymHC4UQWU9feez8KZc@mail.gmail.com>
 <AANLkTikNx-yi5FsK3vVv7MRCxNfEQOM+O5a8EssdpCN3@mail.gmail.com> <AANLkTimnqoNudu66Y+a2R_ttk9ghw7Z-eL1AtcpK=4HB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 28 15:52:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pipgq-0008NB-J0
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 15:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab1A1Owj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 09:52:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50159 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab1A1Owj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 09:52:39 -0500
Received: by bwz15 with SMTP id 15so3274811bwz.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=OkyAjetofDVkF8NdtPo3tzJocTCuiecviDZBl0U0ZCU=;
        b=CMfRawG8QQB69o/YTkV8hIY8fliD1HNwk1ZVP3dDnhBxeBzdicx5EOLJMEjxSzBLef
         maylGAe1EvjQI2FW8qNoY+D6v4qNHjTVrIMBfhJeuOj/JOyCJ2WYMTqmYH7mZC8K9jV1
         9Z3Y53cV9qz6pE1X1LeKevX0RyYKRClKgStrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=bATyaRLURL70fXYaxkjasGrW51kJ+AErOndsAA10BMWm/20zPq5GTYJEa2xsh6zRuS
         ryrVq0QhZIxykHheuYwneeDzsrcVMQlA+QbzT5Ii/dMxHDIq+quenBhDbzJ7PoSDjK+w
         vpZnYXwb1ADSqSlk87ICzgG4P75zelGYOZTyk=
Received: by 10.204.14.6 with SMTP id e6mr668676bka.9.1296226163819; Fri, 28
 Jan 2011 06:49:23 -0800 (PST)
Received: by 10.204.103.8 with HTTP; Fri, 28 Jan 2011 06:49:03 -0800 (PST)
In-Reply-To: <AANLkTimnqoNudu66Y+a2R_ttk9ghw7Z-eL1AtcpK=4HB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165617>

Ah, with git --help help I found that 'git help -a' shows all
available commands, probably by default 'git help' should display a
tip about this command for finding all git commands?

Thanks

On Fri, Jan 28, 2011 at 5:43 PM, redstun <redstun@gmail.com> wrote:
> Just realized in git help the command clean is not mentioned, yet
>
> #git --version
> git version 1.7.3.3
>
