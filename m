From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] hg-to-git: add --verbose option
Date: Mon, 26 May 2008 15:28:54 +0200
Message-ID: <bd6139dc0805260628l1b073f52i1f33bd0c707a4329@mail.gmail.com>
References: <alpine.DEB.1.00.0805261344420.30431@racer>
	 <200805261509.49841.johan@herland.net>
	 <alpine.DEB.1.00.0805261414140.30431@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Stelian Pop" <stelian@popies.net>, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 26 15:30:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0cmW-0004Yc-Mq
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 15:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853AbYEZN3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 09:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYEZN3H
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 09:29:07 -0400
Received: from rn-out-0910.google.com ([64.233.170.191]:19108 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531AbYEZN24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 09:28:56 -0400
Received: by rn-out-0910.google.com with SMTP id k40so843076rnd.17
        for <git@vger.kernel.org>; Mon, 26 May 2008 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8Y9k9mTV6ABftXOQIb8bG891YdB/tuW/d1zDb3+3atE=;
        b=UB59YbB8RQylr2zfQzvbpgkdJU1s0gI+F0XY/LuM3cb2Bq1+Una9XyrWbsxODWstv1rIihpyJipzBZ3AGq+1PlSZTv6rOav42JI8hecyUs6DRofPr6dI67GOB4P2gIbqYx2ryGEhZSi6dQ7jbbHZCWnUW9Hb1neE8mWWywt4ewA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JALjf1E6Vf2B5ZZnE0Z6IDYJD6R7auWWOh73o90AcfaAs+VK0lQ9k5tDElexMLwMNkVaPIgqROXmjPc6l0mYttnWu9jEidXdDJX2ifi5fIcDp30SCEysCARQIy53j/qFi5KdM/mx4aLQFwj7iXcNVQcCcwOlT3Q1wCNeNukZCwI=
Received: by 10.143.159.11 with SMTP id l11mr8632wfo.186.1211808534640;
        Mon, 26 May 2008 06:28:54 -0700 (PDT)
Received: by 10.143.10.16 with HTTP; Mon, 26 May 2008 06:28:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805261414140.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82933>

On Mon, May 26, 2008 at 3:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Now, that is not even funny, as that was my initial version, and Python
> complained about not knowing "false".

That is because in python the keyword is "False" (note the capital 'F').

-- 
Cheers,

Sverre Rabbelier
