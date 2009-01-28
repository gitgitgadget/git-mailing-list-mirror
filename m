From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 02:01:45 -0500
Message-ID: <81bfc67a0901272301y88162f6xc255195d59765ff@mail.gmail.com>
References: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:03:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4SO-0000uP-PW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbZA1HBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbZA1HBt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:01:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:35383 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbZA1HBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:01:48 -0500
Received: by fg-out-1718.google.com with SMTP id 13so431414fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 23:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Qn3hvwNqodtO8DVF/Pc7e5JtJuR1kyRffIbIaDme0Ek=;
        b=TuBpbSe4uBWHY7JltlH5sJwI1I9wo08enxxSRutJp78x1ZliN3KPHGIQNu/hDQMofj
         d3jJ8R8J8E/zG6IfZNbMGuyUL3S4bryhzZiRTXSXJH+YVKBG7jvXrf6JClYo41gO5Ecs
         6c6CLJKHaq1JIXbjqWjEx0CaqolxghAvBFd1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZWg9ES49jrUihgweFNV5iGd66+/siYttk7iGTow6hJ9FThbxPUyxaCFTa2zLZKwXM+
         dd/8J4S5GoBcZQWMc0qGsaupEfEEGgS/vCadIIYVsvKlQmpx3AoL51Q9HgCia9WVLSkq
         ci+Amx/3GCYs0VYApNgVTK9oGYi5St2qm+P7E=
Received: by 10.223.120.197 with SMTP id e5mr2558009far.25.1233126106445; Tue, 
	27 Jan 2009 23:01:46 -0800 (PST)
In-Reply-To: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107485>

better? I think I got the formatting fixed... got the imap working...
added a more descriptive commit message. hoping that everything looks
good.
