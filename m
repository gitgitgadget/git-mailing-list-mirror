From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Bogofilter is my emails
Date: Mon, 4 Sep 2006 17:46:22 +1200
Message-ID: <46a038f90609032246h634cfa4amf5ebe4b41a0f6fb8@mail.gmail.com>
References: <20060903040222.GB29756@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 04 07:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK7Hw-0001Qd-Fm
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 07:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWIDFqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 01:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWIDFqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 01:46:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:39035 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932327AbWIDFqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 01:46:24 -0400
Received: by nf-out-0910.google.com with SMTP id o25so978484nfa
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 22:46:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OFEj8Mngm+PnDn92vKLWlstSCMgGnhNJc8wv8VivdQ2ZG5lFE6Y+l0Fafbw+twtjxFImIBD6pPifurq+7G5EuUJpoMhZspx7nFcOpBkGjvbYDtoCbwE7goZChW9YcJB0IwS81A0YNHEz1+S9jNh2Qles6vE0MS/pO63f+PDidMc=
Received: by 10.48.163.19 with SMTP id l19mr6151521nfe;
        Sun, 03 Sep 2006 22:46:22 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Sun, 3 Sep 2006 22:46:22 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060903040222.GB29756@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26399>

On 9/3/06, Shawn Pearce <spearce@spearce.org> wrote:
> I'm not quite sure how to fix either message to get them to the list.
> Neither email was a patch so I'm not going to try resending them

Well, it's just eaten 2 trivial patches of mine. Grumble.

I am resending them via a different smtp host with the assumption that
the rules may be blocking emails sent via localhost on the initial hop
or other smtp-routing-related rule.

Discussion however seems to imply that bogofilter is only
email-content based? The vger mta admins need to get a grip on 2006
and use a combination of weighted rules to play the spam blocking game
with at least some hope.

Simple rulesets nowadays are triggered by ham way more often than spam.

cheers,



martin

-- 
VGER BF report: U 0.550887
