From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Is there a way to add a default `--squash` flag for all merges
 into a head?
Date: Thu, 10 Mar 2011 11:38:21 -0800 (PST)
Message-ID: <5a2ac540-481e-49e6-9e2e-eb410ba483e0@w9g2000prg.googlegroups.com>
References: <9f02bed0-fa18-46b1-a3d3-346e1cc7dc01@k15g2000prk.googlegroups.com>
 <AANLkTinmdQ6r8cBDsFjXR+KLGeZR1-yeu7h9R=X0+1PG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 20:38:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxlgp-0006dw-PW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab1CJTiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 14:38:22 -0500
Received: from mail-yw0-f56.google.com ([209.85.213.56]:58054 "EHLO
	mail-yw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab1CJTiV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 14:38:21 -0500
Received: by ywc21 with SMTP id 21so1592735ywc.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 11:38:21 -0800 (PST)
Received: by 10.101.13.1 with SMTP id q1mr102203ani.33.1299785901246; Thu, 10
 Mar 2011 11:38:21 -0800 (PST)
Received: by w9g2000prg.googlegroups.com with HTTP; Thu, 10 Mar 2011 11:38:21
 -0800 (PST)
In-Reply-To: <AANLkTinmdQ6r8cBDsFjXR+KLGeZR1-yeu7h9R=X0+1PG@mail.gmail.com>
X-IP: 66.250.141.150
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13)
 Gecko/20101203 Firefox/3.6.13,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168848>

On Mar 8, 1:29=A0am, Jay Soffian <jaysoff...@gmail.com> wrote:
> Try:
>
> =A0 $ git config branch.<name>.mergeoptions --squash

Thanks, that works great and answers our need. Thanks to Junio as well
for the thorough discussion of our workflow.

=2ED
