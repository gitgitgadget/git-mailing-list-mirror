From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 19:26:12 -0700
Message-ID: <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 04:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDt3R-0004bT-Nd
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 04:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbXGZC0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 22:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbXGZC0O
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 22:26:14 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:2734 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755540AbXGZC0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 22:26:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so346607nze
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 19:26:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMQNl2oEJ6bcM6WkGdvUaScW3vWvUU2l9g+2JdS7WTh7eVKRT0X5G8tBdn1stX90PeocMozLU8nddqmGx9G3wYugai0V6WFfXzVbxw30RtQW2Pd2rFzUuLBG4ZUUuuUKJeqfwJ00yKL5cFEtQfztIyTeKIydpFCxsg7/YVacUcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r/PO/iWGcp6QL8T8tpP0l0nPcvVvRyTOWAPXZIuG9AWisyFtNpOJAnKjQGLIGMo7WIJfZFLulh4V3wwtdTo5Oy4wAg52OaA+kFyHsHIRrbWvoVhldWvJa5RIskdVFDAagVQG0+ru/N8+kw/an1zZ1cTIVpam6wYOpEaQ5/6drLU=
Received: by 10.141.88.3 with SMTP id q3mr396285rvl.1185416772956;
        Wed, 25 Jul 2007 19:26:12 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 25 Jul 2007 19:26:12 -0700 (PDT)
In-Reply-To: <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53747>

On 7/25/07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> What features is mingw port missing?
Well, 'git commit' from a regular cmd prompt does not work.
IMHO, That's a pretty serious omission  :-).
