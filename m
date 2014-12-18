From: Klein W <wineklein@gmail.com>
Subject: Re: remote helper example with push/fetch capabilities
Date: Thu, 18 Dec 2014 16:46:37 -0500
Message-ID: <CAPCWLt7+dfcubjEaB=eacNK39CA7Q9K6Mg2FM=_3qQaGBOR2+A@mail.gmail.com>
References: <CAPCWLt6kxoJJSWAcyH_kW071Md0vc4zeo41hCKBQHd-_pvUMXQ@mail.gmail.com>
	<20141215204740.GI29365@google.com>
	<CAPCWLt4=oYTPFXktCj8CgqNncaO2=sbwZcPOVa+a5wgt7HPCUQ@mail.gmail.com>
	<20141215214459.GJ29365@google.com>
	<CAPCWLt5pW6kwP4FCsJqG+o5d=p_WgKMSXqaANY7vSe6Bh7tMxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:46:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1iuA-00063a-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 22:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbaLRVqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 16:46:40 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:50298 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaLRVqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 16:46:39 -0500
Received: by mail-la0-f48.google.com with SMTP id gf13so1793469lab.35
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2zFJPacFwLcofQ0a7/aOG1kinIkbCvbwNX53Wt1vVgo=;
        b=r5hJiP0NE6jdu5tmf/U15hdzxUvDRt9UzrsmTpMQdaIeOiQkbpfjaOeyIYoJV0b99i
         x9s2VP9TIEH+ucXZS83PfVk2GDOimWcs8ll5tvyvF0W5u4UguNgS2EF6B2KlTVwUPqwq
         foYPLxZ1CWF8Qr4RovDfCYHoIbEEcuXVNxVBpOM5qtoToDJTcLLEprVGNBGaPy6Xb3TX
         ZB4bkd7QohwUhnoJpbvxgHqr09nO8C48AawAP/+9X3k3c5bEXmZYodzVz/fFFfKZYWy3
         Wmt7DBXYoJRp1rPEXn3xe6mYMwcyUljJzPDlpQH82+FtkjSHNueyzTln6xoYIKzlQgmH
         VucA==
X-Received: by 10.112.16.129 with SMTP id g1mr4531749lbd.30.1418939198046;
 Thu, 18 Dec 2014 13:46:38 -0800 (PST)
Received: by 10.114.216.100 with HTTP; Thu, 18 Dec 2014 13:46:37 -0800 (PST)
In-Reply-To: <CAPCWLt5pW6kwP4FCsJqG+o5d=p_WgKMSXqaANY7vSe6Bh7tMxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261536>

Would someone be willing to extend the git-remote-testgit.sh example
[1] with push and fetch capabilities?  I am not familiar enough to do
it myself.

Thanks

[1] https://github.com/git/git/blob/master/git-remote-testgit.sh
