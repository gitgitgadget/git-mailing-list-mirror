From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 17:40:35 +0200
Message-ID: <81b0412b0607060840g4df16edbm7df69d6c8edcc071@mail.gmail.com>
References: <20060706124025.G325584e9@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 17:41:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyVy4-0004KZ-8J
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 17:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbWGFPkh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 11:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGFPkh
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 11:40:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:22956 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030347AbWGFPkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 11:40:36 -0400
Received: by ug-out-1314.google.com with SMTP id c2so290414ugf
        for <git@vger.kernel.org>; Thu, 06 Jul 2006 08:40:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VJR0IaNoZ+uWw5b6EXdkdT8wMPxGgo7sDPGMyKK55h0hQ/iJoTbjW/wnQSwKCJdQH+Lt3DfGlBzk4/xlUuNmHub0TnA/AAOFPfsfe6v9b+QE9T2ZUyAHtQXKGMWZ+OULx8WovZetNZyVq6WfVAn6OHnlB9emFV7Vsw2LE+RcjBk=
Received: by 10.78.122.11 with SMTP id u11mr259149huc;
        Thu, 06 Jul 2006 08:40:35 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Thu, 6 Jul 2006 08:40:35 -0700 (PDT)
To: "Dennis Stosberg" <dennis@stosberg.net>
In-Reply-To: <20060706124025.G325584e9@leonov.stosberg.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23395>

On 7/6/06, Dennis Stosberg <dennis@stosberg.net> wrote:
>  Miscellaneous options:
>    --cc=COMPILER          use this C compiler to build MPlayer [gcc]

Is it still MPlayer's?
