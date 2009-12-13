From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: strange error while pushing
Date: Sun, 13 Dec 2009 23:57:01 +0100
Message-ID: <40aa078e0912131457ge5ee47j6d436e1fb73b9d37@mail.gmail.com>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 23:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxNI-00018b-MP
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 23:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbZLMW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 17:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbZLMW5H
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 17:57:07 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:62831 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583AbZLMW5D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 17:57:03 -0500
Received: by ey-out-2122.google.com with SMTP id d26so740569eyd.19
        for <git@vger.kernel.org>; Sun, 13 Dec 2009 14:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=nWbBPudwpq1CaYMl2DVS/vBa8gKoGC1Ew4qRVr4gVlU=;
        b=lhDN1UeIqr5JoGWY9ksZ4BXHVIuph6Xx1lSWXCldz3Ag9yWcpn8nSZqBol9XbRzZve
         4+4gqtgi0mj2utnIoFJLS+PuoeDJ+qL262c74bWCtaZ4HW42zoH+yirCM3Vb65LwesmK
         +UwS4nE2u7PNxTrLaJFy+DQc3g+sNARRzX9F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        b=PsgPCTxnzKxjosaYFIknBeiEMPVbAQrnFxbEKPWklq0L9I9l/CTg7VZzJ7sMLfrHSH
         VIUO5erIkrQcfiZk1pnGcH9jWdDqC+KPxBjlQOF+Ui7OX8LzhlfjcM6dEYBeo1B6Sn+u
         rprTWDOtVGnUHe5+YFK/JvnBZv+jVbyg8mTHY=
Received: by 10.216.87.131 with SMTP id y3mr1696870wee.9.1260745021575; Sun, 
	13 Dec 2009 14:57:01 -0800 (PST)
In-Reply-To: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135156>

On Sun, Dec 13, 2009 at 11:41 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> I'm not entirely sure if this happens on the local side or the remote
> side... I've tried with a few different versions locally but the issue
> seems to persist, so I'm starting to suspect it's an issue at the
> remote end. Any insight, anyone?

Pushing to github gives the same error, so I guess it's a local thing.
I'll check some older versions.

-- 
Erik "kusma" Faye-Lund
