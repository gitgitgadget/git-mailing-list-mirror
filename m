From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 06:15:38 -0700 (PDT)
Message-ID: <m3skt1s0c6.fsf@localhost.localdomain>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 15:16:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVR4r-0005YG-10
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 15:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYHSNPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 09:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYHSNPp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 09:15:45 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59848 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbYHSNPo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 09:15:44 -0400
Received: by gxk9 with SMTP id 9so4978864gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=H1DYfMXbCa9khL5k/3VnqgoTDsDqa/YAlZmcCNWF8XI=;
        b=JGjsPQl4CP9VxqvK96KTa45xJovy0vckfXLJ+MQ/Z/4AvOzWXg+OMPiNSvwuP/3b4K
         Fxa5KKlDgH+OxD8RkKwxWZwgWgKM/5X0beECuqds0DQuKQIqh9/D83ZnebZfMeg3ZkmG
         hvrsuOMIYZC2J09fEZdyQPZiI9Fv7iTyo88ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=x11x3Sp8b0D7KEgGbM1kwzqKBI8peOm3uMhLN6isBYbxH6SMmOLPr5di0IORnOW5Fg
         HclwPEKAXI3qeRAC8fjzPQR7GPdPbquo6eHqC51m+M3lEreUqr9j/yEyk4sTxHeJXBUW
         oK1kNhPcLlLHSgxeW5PgG7SkKLMXcRvfiHUfE=
Received: by 10.150.181.7 with SMTP id d7mr11839510ybf.136.1219151742965;
        Tue, 19 Aug 2008 06:15:42 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.242.212])
        by mx.google.com with ESMTPS id j13sm317816rne.4.2008.08.19.06.15.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 06:15:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7JBaieH002275;
	Tue, 19 Aug 2008 13:36:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7JBagkb002272;
	Tue, 19 Aug 2008 13:36:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92854>

Trans <transfire@gmail.com> writes:

> Well, after a few days of using git, I've decide Linus is too smart to
> be designing end-user interfaces.

Actually git was developed and designed in bottoms-up fashion,
in the "worse is better" way that is quite characteristic for
UNIX tools.  And the mantle of being git maintainer passed
to Junio Hamano before git acquired truly end-user interface
(as opposed to power-user interface).

As I can see even if you didn't provide any details about _what_
do you find difficult in git end-user interface (you are using
current git version, and reading up-to-date git documentation?),
git UI continues improving, even in this thread...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
