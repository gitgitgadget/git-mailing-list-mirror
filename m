From: Laszlo Papp <djszapi@archlinux.us>
Subject: Re: Implement --password option for git svn perl script
Date: Thu, 4 Feb 2010 08:45:02 +0100
Message-ID: <a362e8011002032345i426d262uf26165320385efdf@mail.gmail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com>
	 <001636ed7681994278047e4e4a6f@google.com>
	 <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com>
	 <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com>
	 <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com>
	 <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com>
	 <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com>
	 <20100202090538.GA28437@dcvr.yhbt.net>
	 <a362e8011002020516i5d5adcf7k6553d62e633cec88@mail.gmail.com>
	 <1976ea661002021547ue22909cy27009c1b8743ecd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcwTk-00072x-Ue
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 08:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757192Ab0BDHuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 02:50:15 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:64738 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757026Ab0BDHuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 02:50:14 -0500
Received: by yxe27 with SMTP id 27so1953742yxe.4
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 23:50:14 -0800 (PST)
Received: by 10.101.164.1 with SMTP id r1mr867924ano.153.1265269502215; Wed, 
	03 Feb 2010 23:45:02 -0800 (PST)
In-Reply-To: <1976ea661002021547ue22909cy27009c1b8743ecd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138956>

On Wed, Feb 3, 2010 at 12:47 AM, Frank Li <lznuaa@gmail.com> wrote:
> Is it possible use OpenSSH method to let GUI to input passwd.
> environment SSH_ASKPASS, which point to a application. when
> passwd need, openssh launch this GUI application, =A0user can input
> passwd at this GUI application.
>

What do you mean ? Should I install TortoiseGIT with openssh client,
so should I need to choose this option from the 2 facilities ?

Best Regards,
Laszlo Papp
