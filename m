From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit4 and top of git tree
Date: Sun, 25 Feb 2007 18:02:54 +0100
Message-ID: <e5bfff550702250902q11b74fecvce1ea9d79dec8f92@mail.gmail.com>
References: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 18:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLMm4-0000Lr-DS
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 18:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbXBYRC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 12:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbXBYRC5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 12:02:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:17285 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbXBYRC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 12:02:57 -0500
Received: by wr-out-0506.google.com with SMTP id 37so328768wra
        for <git@vger.kernel.org>; Sun, 25 Feb 2007 09:02:56 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MioPt5GZpkIVyPDLu4CVGUc6a25BelhIQtABA8gGCNmADYhQFiNI9jR42pKm/RpE+hqHjgRmytU45vc9q6vXsEotHCKrJjG0tC1cJn7+mJVYR3a0eb3jqsQaHFMb5q485VfdV40fkmpGt/00D868DAIgGpuwPpNHYAE34wbD9/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZO/zUvU3nSCjeMm8cqRf7Xf3XptBWGPZSjw08tbe2/APLYm+KYZ/uBNqnGam2daWgUTQi3opSzJ0ZvoLdjFjqOjI78rpwdPKotxne0xpflZc9s+xDZCt+HYtD9AU192k2iY6pDx90qKpdRaHlfCBQMcGDF38z2wfYNEgtJT794E=
Received: by 10.114.80.4 with SMTP id d4mr357987wab.1172422974607;
        Sun, 25 Feb 2007 09:02:54 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sun, 25 Feb 2007 09:02:54 -0800 (PST)
In-Reply-To: <cc723f590702240803o24ca01ffxfea904bf7b11c05@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40553>

On 2/24/07, Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> top of qgit4 and top of git. The top level commit is not displayed
> properly.  I guess something related to commit parsing went wrong.
>
>
Thanks Aneesh,

patch pushed....stil not clear why it happens though.


Marco
