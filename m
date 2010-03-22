From: Jacopo Pecci <jacopo.pecci@gmail.com>
Subject: Master branch not updating
Date: Mon, 22 Mar 2010 18:43:32 +0200
Message-ID: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 17:44:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtkjX-0003Ix-8n
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 17:44:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab0CVQnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 12:43:55 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:61946 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755270Ab0CVQny convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 12:43:54 -0400
Received: by fxm23 with SMTP id 23so918360fxm.21
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=QGkBS47fvR/qob1fNm5ByReeyV7yvn3e5Kf4ObQa33M=;
        b=ulNLRZNNEuo97UlefCE2WgMfEgOUJzQnD1oRrzgXD9kl4lgrTkmm9YPDDndnoXHWE3
         JP64AMg8/RNQamShY6+DY7afEpKExXVoToJspkBPS6AszolZGlPHSBudzZ6RyLYx+zdo
         7S5Sod8luAliLhhoMZL5BZz18TnFKRsc9MG+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=KF0C2MfeD7sLwRucTc3/clSLcgIUTsb2gRK2caEZOuWZKFGnP0NKezplDmOw243Cpy
         sVr+N4zpmmGGKrKuAruvS6DaRDWgT/J+aiNnciriheUKZYvIO/2aWxbxW4N0m4dr/pf5
         Zof7fvqlmB6NLXRhUnQsePm8g/wP8YvFH9YfU=
Received: by 10.223.4.132 with SMTP id 4mr2047031far.90.1269276232144; Mon, 22 
	Mar 2010 09:43:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142945>

Hi,
I have a simple local project, with only the master branch. After few
commits with Git Extensions, I have realized the label [master] was
stuck, it was not pointing at the latest commit any more. Nevertheless
I could see a full list of all my new commits with the proper comments
in the main window.  It looked like I was not on any branch (if this
is possible)
Then I have tried =93checkout master branch=94, suddenly all the commit=
s
in between the one labelled [master] and the latest one vanished. I
have not been able to get back.

I am terribly afraid I have lost 4 day work. Do you have any
suggestion? How is it possible that something which I have committed
is not retrievable anymore.

I beg someone to help me

Thanks, Jacopo
