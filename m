From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: How to merge git://repo.or.cz/git-gui into git.git
Date: Sun, 28 Oct 2007 19:00:54 +0800
Message-ID: <46dff0320710280400v523e2130nd3286a88a4920a9c@mail.gmail.com>
References: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 12:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im5tE-0007rZ-Bf
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 12:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbXJ1LA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 07:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbXJ1LA4
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 07:00:56 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:35143 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbXJ1LAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 07:00:55 -0400
Received: by py-out-1112.google.com with SMTP id u77so2276210pyb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 04:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8PLTVRw/ivv/WN3LGBi+IvZSmhoSCzgLMzfr7Y2AHeI=;
        b=cLaBviFvHiHrtyPMwlcCo26NraSfqYFl5yDvtcHte1UFK0poS1RivF3yK4BSmZ6qTD+Q0YtevRGVBH0QvGVeVcp9ZZz0JjME7P0whqcb+CcpGRIx4plOuifNvnhU6isEGwuSyJVdK6I15sUn6caMS5ZhBt2EiC+34XE1+s4WdMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j9DCMWB8Kcjl8qBzs1t98mf3UmFxaQumWjcloWeo7TS1OXeJXxUkGTTeW5/YA0f4Jz0jgC/oRxMqKJxATxmjSUkBmKGHu78vIEE3EB3jBGyKzadQ5O5ueqvjbJ+Cl6uH+ag5ofRGkLWOPyDw+9/WDBKxDnoICmujwYnQ4WhERhM=
Received: by 10.35.98.3 with SMTP id a3mr6001222pym.1193569254428;
        Sun, 28 Oct 2007 04:00:54 -0700 (PDT)
Received: by 10.35.108.1 with HTTP; Sun, 28 Oct 2007 04:00:54 -0700 (PDT)
In-Reply-To: <46dff0320710280357u23927960hd204760b3d664ce2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62552>

On 10/28/07, Yin Ping <pkufranky@gmail.com> wrote:

> When I type
> gtlg --topo-order --pretty=oneline --abbrev-commit e92ea624 -p
Sorry, my fault. gtlg is an alias for git-log

> franky
>


-- 
franky
