From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: split up a repository
Date: Wed, 3 Mar 2010 00:19:48 +0100
Message-ID: <fabb9a1e1003021519y7159a3dal3aa3a7514329fb9a@mail.gmail.com>
References: <20100302011226.76fda85d@gmail.com> <fabb9a1e1003020240h81f3e99wea1185c080a03b0@mail.gmail.com> 
	<20100303002132.5df20326@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Levente Kovacs <leventelist@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 00:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmbNw-0000eF-Ck
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 00:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab0CBXUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 18:20:10 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54517 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab0CBXUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 18:20:09 -0500
Received: by pva4 with SMTP id 4so239242pva.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=kzf/Mfl94Qxy8IN7YubLYO7xo866o3cPpH6IrIWGJns=;
        b=yBP6Hp4LeMj72Y+xisw+o5khGWYY36QpFHkO92IzIClFy1ob4CLqZcaM+9Gp/Vjra+
         rO26qp4En851As3uha4Q+ON4OwaQ4wRZDajNuAPht2ztWh8BfHS+DZQ4Xk9JCEX7GDR6
         VlWhL+FAJY4/VYoKHL7cCmnZXqc7gl8yAGJaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aH90i+anMTae4UBBUV+PoTJaHpFY7c4i4vmbWqkjJMDNb+9PtMexs9ZD3yxvtCoTAK
         nYAoOGHtW80Pw39IQGPFsI720MRb9x7wBuVsxtvdtef1wvHjFs2sFz8nL+yGPQw/H1Cx
         n00xmQQtFYEexNGahg04bifpMhGdve8FzYLX0=
Received: by 10.142.208.12 with SMTP id f12mr102304wfg.128.1267572008104; Tue, 
	02 Mar 2010 15:20:08 -0800 (PST)
In-Reply-To: <20100303002132.5df20326@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141423>

Heya,

On Wed, Mar 3, 2010 at 00:21, Levente Kovacs <leventelist@gmail.com> wrote:
> Ok. Really newbie question here. Just before I start to mess up my
> repositories.

PROTIP: Back up your repository before messing with it ;).

> I've cloned the git-subtree, and the install script would put
> the script into /usr/lib/git-core. Is there any way to install the script
> somewhere under /usr/local ?

I'll leave git subtree specific questions to Avery :).

-- 
Cheers,

Sverre Rabbelier
