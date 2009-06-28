From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git push failed over http
Date: Sun, 28 Jun 2009 21:47:56 +0800
Message-ID: <be6fef0d0906280647o6ff292a7t334525f95cba41@mail.gmail.com>
References: <82ec251f0906280020p71026a81w57018e9af4d39396@mail.gmail.com>
	 <m3y6rcwz5f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lynn Lin <lynnos@tong-ji.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 15:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKujk-0006jE-DN
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 15:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZF1Nry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 09:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbZF1Nrx
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 09:47:53 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:57974 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbZF1Nrw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 09:47:52 -0400
Received: by pxi28 with SMTP id 28so2840458pxi.33
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tYFrez3BXt5K9EEFld4SJjnJvOR09uEFI3DyaHJm2wE=;
        b=O7sayLbqLdr7x03zd9U3Zb/d7QDPVggYxvKWEE8ZDsjJ7b9THf3zUMG9ItRlFLZE7C
         hza9nOw1KZ0WtCghi+O/FzG4zyzrROT4AM3VJN9USXivBNWYlUOzGipmdXi1uZmrnlTu
         ANPgzRUu+85Yzl6Mbk252SoC6lu+B6GK+AodM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OEzsvlzuQytcAXTAxpVQKVZJUsZVtxU1x9S3TjFCN+i7IqAFd5Fg5ugUcEh1apooSS
         Nf5nhYuJjctj+nCGNlDoSlnNICRXQnG7b0brVGkGw5CDX6CCUzFyOFj4z0MhmxMKq8QJ
         uNDRqRYczzDjaUEaOfKgiTPKnZINYJee4ujfo=
Received: by 10.141.27.16 with SMTP id e16mr749689rvj.79.1246196876088; Sun, 
	28 Jun 2009 06:47:56 -0700 (PDT)
In-Reply-To: <m3y6rcwz5f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122403>

Hi,

On Sun, Jun 28, 2009 at 4:11 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> First, you push over https, not http.

It's possible to push over HTTP. Authentication methods include Basic
and Digest.

-- 
Cheers,
Ray Chuan
