From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: forcing add of CRLF modified files
Date: Wed, 15 Jun 2011 20:43:02 +0100
Message-ID: <BANLkTimbhK+Xq59UZ-ad12W2e98HoOn_1A@mail.gmail.com>
References: <BANLkTimG+4u4jhgvG9xtEQ02yBu3kxDD2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 21:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWvzv-00040V-8J
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 21:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab1FOTnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 15:43:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43617 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab1FOTnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 15:43:24 -0400
Received: by eyx24 with SMTP id 24so293628eyx.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=mcNjO8InI6JJBIU1y6sfPAEEQ6QwyyTvlhymZhvpWVs=;
        b=cRL2PxVsovuQEGkWCfqmggbjUQCDiQzYjsklfNjYrRVhIzJH8M5oZdWRjlHsjLcsf7
         GoL92OGAyClXRq9hleUruYbKxvmy40e2BGxwYiMfQuODNRGpyS460qmu7muvmo7ciYc+
         nqOkFbx+JZQyMzhlQu2Mza+AbURb/bvZI+7nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=acquF8vUJ3+2d70ruH/fD35QXpYsvGqY7GwEkjTOkTcJrg0pC1+vt/35Km4okihEkH
         50RAikAa0FcgchEAZg5fGPob8YS6T39aVNe6giQozCVKX83CwSF3mlgPbR7OC7wG10Se
         wvsfurnwdMSMPctsQjx/YXMSYxbmi8iTaSzzo=
Received: by 10.14.15.20 with SMTP id e20mr13365eee.16.1308167003257; Wed, 15
 Jun 2011 12:43:23 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Wed, 15 Jun 2011 12:43:02 -0700 (PDT)
In-Reply-To: <BANLkTimG+4u4jhgvG9xtEQ02yBu3kxDD2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175847>

On 15 June 2011 18:31, Aaron Gray <aaronngray.lists@gmail.com> wrote:
> I cannot seem to get GIT to add files with corrected CRLF line endings
> against the repository with incorrect LF only line endings.

Ah, my mistake, editing wrong VS project !

Sorry for the noise,

Aaron
