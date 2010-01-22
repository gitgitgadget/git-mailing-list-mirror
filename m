From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-svn question: adding a branch to a local clone of an upstream 
	git-svn clone
Date: Fri, 22 Jan 2010 17:43:29 -0500
Message-ID: <76718491001221443x655db9ddidb5feb66f289c2cc@mail.gmail.com>
References: <76718491001221115r56c1f6e4qbf6cecc30ce4af58@mail.gmail.com>
	 <76718491001221203y54c3ec5br8fa7a40b5dd7da6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:44:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYSE9-0002Px-PN
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 23:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab0AVWnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755050Ab0AVWna
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 17:43:30 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:37896 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab0AVWna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 17:43:30 -0500
Received: by iwn16 with SMTP id 16so555322iwn.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 14:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=jsFP+Q9kHxCrUCVpWmq1lK9pBAlmzlwB4pBfXHNJ9Dw=;
        b=C8EIu4Sa9Z0u0H3OGaU8On0a5FWszkYhhNnJiNMFyEmzANgAoxSqLZKdPcSoOOi+kp
         8SFb8Bzrpi3U+9R0EpBWxiAitlt/JK9vqQ8HmDt5T8IDDVofeRaC7cEB17CGzBAIWkAV
         hPumgab3j41SECi3mtfpgK9zRA0BtNaazTIR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=v70Fvmw6OtahHc+lhL3fctdxDoeo5wOPajVS1xM93l4GEIpRDgu4jEswXOMcu/t+Uo
         nzLbf5jErSfop50+1GdzhB/KkA1jb3/fxCqIeugztDl4uafVVIAdSxG+7r69ALG+YyHN
         FqDooxdavljtq815E06GL3mkHUE66uKo170PQ=
Received: by 10.231.162.9 with SMTP id t9mr5846766ibx.5.1264200209434; Fri, 22 
	Jan 2010 14:43:29 -0800 (PST)
In-Reply-To: <76718491001221203y54c3ec5br8fa7a40b5dd7da6a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137785>

On Fri, Jan 22, 2010 at 3:03 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> So, no help either. :-(

Okay, got this working with some git-svn hackage. Patch forthcoming.

j.
