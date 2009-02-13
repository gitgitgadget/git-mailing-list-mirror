From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git am and Evoultion
Date: Fri, 13 Feb 2009 13:47:13 +1300
Message-ID: <a038bef50902121647w13c83ceew8e8e3f68e98477c9@mail.gmail.com>
References: <a038bef50902121413p784c2563l8823c7dc758a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 01:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXmEV-0002o6-O5
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:48:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbZBMArP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbZBMArP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:47:15 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:7986 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbZBMArO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:47:14 -0500
Received: by rv-out-0506.google.com with SMTP id g37so493858rvb.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 16:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=M3B2IrUNwDeG1BMFYgmWfmVT7eVF7Vyp3SW019LRNNs=;
        b=BBGNTNvbNZR6Y0O0LJIl8NfjnpC1uFW7r1dNnQBv2p1V48dLWo0+DV0+AezJna+j5O
         BQC2K5OGTsgJNzFkKgc/Qeoyj+ZJr1UbNRcD0TizUpKpJktj7Ry+RjLshdrwajQpHMmk
         LDpsMUw2PgGl4Fqw93vkFVJzCSTm1JBdrZPxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=bNkKwcuNmE8Ag6s9Uh8SIBRqXl7VdC/axV9ko6AePAa4jfOmQtcvRVsBaIkadNL9dl
         O4ECMDRm19F4mgy3raH82MRyyIl9hfN61DXRSPvhvAl6uoGQUer5zj7gjsOLFDyUan2k
         bmXW/p9cNwNOUOb7BFbAiPTrhNz7ej15OecT0=
Received: by 10.114.131.1 with SMTP id e1mr631497wad.222.1234486033707; Thu, 
	12 Feb 2009 16:47:13 -0800 (PST)
In-Reply-To: <a038bef50902121413p784c2563l8823c7dc758a73@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109695>

On Fri, Feb 13, 2009 at 11:13 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Caveat: I'm running an old version of git (1.5.4.5). I've been putting
> off upgrading as the corporate overlords are planning a wider
> distro version upgrade which would include a newer version of git.

After actually trying the newer version the CRLFs are handled nicely.
Sorry for the spam/not searching the list first.
