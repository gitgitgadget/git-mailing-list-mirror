From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 10:49:14 +1300
Message-ID: <46a038f90801211349mfb57c0an9416832c2967c172@mail.gmail.com>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se>
	 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	 <20080121195703.GE29792@mit.edu>
	 <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org>
	 <20080121201530.GF29792@mit.edu>
	 <8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
	 <20080121204614.GG29792@mit.edu>
	 <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
	 <20080121211802.GH29792@mit.edu>
	 <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:49:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH4WY-0001pj-BT
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbYAUVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752366AbYAUVtR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:49:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:38207 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbYAUVtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:49:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so960935ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 13:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0gaF348LbDzWqeUBUEquPRVQhisJPYl29qg+3NVTP8s=;
        b=DmIhlgoVmzION4jHl+WvSCwTp1SbUROHQDlHdCEV1+E49SxvL58bbNPloYeNT0nO2VfW4g7+PyxZ4TRhZeHEj2FvIT8qPK0v4cep+kNP7WGz2Y5cOYOkTypTuWq9tUIIw5gLM45CKeOVpT+8ck8mkcqg9ZWw0TEJPrvCPn67hA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DdTY9N+U7zf8sffrIb4x+JeYM7cwr/asuPpifD/iohHbISDPnHnOpUCBWZHLWNgiCI9rihuTGSDx4FYf6l0NpvX6UxwKvY9/8aufIP4sX4tTOrKYcrU45qtSxxwrNQixH+Eiz6F+7FHvQe9+6LgSyB1075irQWJ/RINF88l5AP4=
Received: by 10.67.19.13 with SMTP id w13mr4941097ugi.19.1200952154387;
        Mon, 21 Jan 2008 13:49:14 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 13:49:14 -0800 (PST)
In-Reply-To: <45C7CC4A-155F-4FE4-B741-8EE6CF7D3700@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71353>

On Jan 22, 2008 10:43 AM, Kevin Ballard <kevin@sb.org> wrote:
> How many times must I say I never suggested actually changing git's
> hashing algorithm? And if you want me to suggest a fix to git that
> works, first you have to wait for me to learn how git's internals
> work, and frankly, I have too much work on my plate right now to
> devote the time necessary to learning git's internals well enough to
> fix this problem.

LOL! Spare us the flamefesting and you will have plenty of time for
learning git internals. You might even learn something.

cheers,


martin
