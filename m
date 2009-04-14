From: David Symonds <dsymonds@gmail.com>
Subject: Re: making docs
Date: Tue, 14 Apr 2009 23:14:09 +1000
Message-ID: <ee77f5c20904140614ofa0753apaec52584f2a3878c@mail.gmail.com>
References: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 14 15:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtiUL-0005LE-HB
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 15:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZDNNOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 09:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbZDNNON
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 09:14:13 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:64677 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbZDNNOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 09:14:12 -0400
Received: by ewy9 with SMTP id 9so2638271ewy.37
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tFfBevqQvhG8Zb7pXRbuaF1WlNVx8eBEzyo956tfOIg=;
        b=LdcMozbM4RwjhrEGv+Muv3F9J2fiwLdqwBbdPyOdoWXvWs5dAbUVOOh03bezFL0TKo
         WT9PpN46qvJpHZqAz+h1FzrVKMzfNcGJREX4KU1IcDRV6NqTB0RnkGIV5bDBNbjJO59k
         FrdyHEY4O22ZoUdgvkgnWQOohuDwHSZDlbaGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=c/QC/3GCo6/A5vetrH38XyuzCtbK1cwd+ZGyxDSrYmeyMytH4O+AzGEq6vmOZP3xtS
         TgpMNYJ5XUy5Ta0SmkRMBH60lycqpJ0HA6mpPjpNtPIyj57w4dCH6W52bKaU+6NZBPe2
         f6KTrJwk+Nzt8yV5v2DI6JSFVWVWoWLUVqZ7A=
Received: by 10.210.62.12 with SMTP id k12mr2917716eba.44.1239714849936; Tue, 
	14 Apr 2009 06:14:09 -0700 (PDT)
In-Reply-To: <49E4A72D.21604.198A9AD@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116536>

On Tue, Apr 14, 2009 at 11:09 PM, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:

> 1) Pre-build the documentation (manual pages) with the source archive. If the
> sources are used unmodified, the manual pages should be fine

This is already in the git.git repository, in the 'man' and 'html' branches.


Dave.
