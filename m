From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/13] credential helpers, take two
Date: Thu, 24 Nov 2011 12:45:39 +0100
Message-ID: <CABPQNSaT+4F=EW_agAh_FY0h_ZRgMCzpukdKuvZTdfmz5_Nueg@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 24 12:46:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTXl4-0005ga-Ah
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 12:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab1KXLqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 06:46:21 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52472 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab1KXLqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 06:46:21 -0500
Received: by ggnr5 with SMTP id r5so2455859ggn.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tXIT3yOyyVoLHuohWx9J41YDOT1qoYIvIHvLe9owsTQ=;
        b=Tk3h+pwTkm4eFFlyMRT3Sv6WfUJAS84duXXnXHfH6AEE+QG23HHSNnpPLm2gdNi7uz
         W6ZE9+O6kv2Y0foX+uBWnWv23mvLMolqkiXA5ry9KYdayDbRyq9imuV/u8MSmIYyrOCU
         GKxx+eKPf2OF2zec7OUbXwHuHbA2UfyrUCGU8=
Received: by 10.68.23.226 with SMTP id p2mr3060359pbf.122.1322135180041; Thu,
 24 Nov 2011 03:46:20 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Thu, 24 Nov 2011 03:45:39 -0800 (PST)
In-Reply-To: <20111124105801.GA6168@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185909>

On Thu, Nov 24, 2011 at 11:58 AM, Jeff King <peff@peff.net> wrote:
> Here's a revised version of the http-auth / credential-helper series.
>

Nice. Do you have the branch somewhere public I can pull it from?
