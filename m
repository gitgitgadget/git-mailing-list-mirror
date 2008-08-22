From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Debian packaging update
Date: Fri, 22 Aug 2008 22:52:40 +0100
Message-ID: <b0943d9e0808221452h6b9b0e99q795cd73cb44e5b11@mail.gmail.com>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	 <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
	 <20080822235154.5e1f979c@whitehouse.id.au>
	 <20080823010325.33fe9e1c@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: "Daniel White" <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:53:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeZl-0005u2-N4
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbYHVVwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756200AbYHVVwl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:52:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:14681 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbYHVVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:52:40 -0400
Received: by rv-out-0506.google.com with SMTP id k40so614636rvb.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F+4HAe8wExh1cHp8JuPYnv8xfh2goTjW6z22I3lVc8c=;
        b=f0p+l1gvDyk14KKvwx1kMU/83TgFGnyRlqT7T7P4UJlwVEU7lVywfxSJ6+Qpzqj1iL
         Uefxm9/WQTCaJdm6IkuJlBf2HMPKidK6A6Zzpu/edQWm3LrYhaLiwmzxqZeQQipqjQ37
         YLVbG590W261w1AycBRjgugRU44goaaYfBRUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gLopJaMJGV0yDZVvCLM5ZfzhAz5UBor15+lTZDFf3HVfx5OYLeepyUXLi3aCVnHR77
         t1yg0DcBsUlaaQlm34Ch8dOlo1XNHD0fl2V27Y2D0+Z7oAV4tT9xswuQ6+uHxIgeLNHX
         5rX+OOlypIprn5jbwYOwEOaotgq7HXBsVuuBg=
Received: by 10.115.54.7 with SMTP id g7mr1562301wak.212.1219441960218;
        Fri, 22 Aug 2008 14:52:40 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Fri, 22 Aug 2008 14:52:40 -0700 (PDT)
In-Reply-To: <20080823010325.33fe9e1c@whitehouse.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93380>

2008/8/22 Daniel White <daniel@whitehouse.id.au>:
> Not that it probably matters much, but I forgot to sign off on the
> changes.  I've re-pushed the changes.
>
> So the commit to ignore would be e4a257f0.

Thanks. I picked the other commit.

-- 
Catalin
