From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4
Date: Sun, 3 Feb 2008 20:55:35 +0300
Message-ID: <20080203175534.GT29522@dpotapov.dyndns.org>
References: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 18:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLj4k-0008Lq-Qq
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 18:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbYBCRzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 12:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756420AbYBCRzl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 12:55:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:19430 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbYBCRzk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 12:55:40 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1727010fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 09:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=TKEOJbISKoAr20+JJw9jir7dU6llaiAPMgs7um4m8Pk=;
        b=nRWSU0WzIiH7shraULe6R8lo8JIO0vmhjw3qi9Jn+u/CPmGl6g4BlQUrg7fxaC+NVmv79jKtBSEw7wZQ2Iuwl6MAMe6Ydcr1rjtlIHEykgf8briRlJ9jU0bckRCwVRbcm8wiZqVqM8o2uY/IZXwlTfeu09DibaOb7DMrbHD8bvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=gsT3eKvyrc6jV0dBQUDbLEyEDuYidNxdaXSJLIUa3OUF2l0t18gSaFEnKeUZSumdxYnWGg9/qy5TbpZ+yGDxjrjNA1F8c9ml4wFi1HfnoawQ9RVcOqO7KvafF9Yg1BQSp9Dq5036Rv5on/+JIJXgCNndYVCnkEFN+pnes7Bzogs=
Received: by 10.82.105.13 with SMTP id d13mr11235853buc.30.1202061338651;
        Sun, 03 Feb 2008 09:55:38 -0800 (PST)
Received: from localhost ( [85.141.189.132])
        by mx.google.com with ESMTPS id a37sm6170182fkc.3.2008.02.03.09.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 09:55:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmyqk563z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72385>

On Fri, Feb 01, 2008 at 08:34:24PM -0800, Junio C Hamano wrote:
> The latest feature release GIT 1.5.4 is available at the usual
> places:

Congratulation to all Git developers and special thanks to Junio Hamano
whose dedication and efforts cannot be overestimated. GIT 1.5.4 may not
appear a big step in terms of version numbers, but it is really a big
step in making GIT even much more user friendly. Thanks to everyone who
contributed to this release.

Dmitry
