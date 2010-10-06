From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Someone using GIT and Maven?
Date: Wed, 6 Oct 2010 12:46:50 +0000
Message-ID: <AANLkTimgbxLiz5pNZTwvq-xjj_dEuf9L9PEf=zEe0bv0@mail.gmail.com>
References: <1285913490619-5590307.post@n2.nabble.com>
	<1286365670193-5606731.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: cdossantos <claudia.dossantos@ricoh-europe.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 14:46:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3TOc-0007RQ-HH
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 14:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356Ab0JFMqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 08:46:52 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43567 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0JFMqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 08:46:52 -0400
Received: by yxp4 with SMTP id 4so2415868yxp.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yQJad0SRcymUgJSbW0AvbqNhKZTclRzqzti+zpUXd28=;
        b=cz2feJLv8x2nIBGp7fKd18KLUWODhZYQ9bDpsi+0CnVuWZfaATP4ET54Zbs6mkC8o6
         acqyIE4tI5YISoRYt/YDYEcLNAmeydgrtHku8lxJWgntS6mFFhiwVI8PMROZefpyWAbQ
         TMCdzsFd0P5uDOt3SdL/+g/nCX9pkdDuxu6Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Ou+Z2987VK5z/YKm0XtXt6gP39yaMowJXOLXBkHbSah/HKl6mSI0+vcoGAbCCPu45c
         8YO/i9W9MvP+El4hyLIg3YKgA+BCY7z1XtcFMOZD4la92H+cIXVQNw4oK596yUYgqT9j
         cVx3y1sX51flTdLsCOhZt7yd9F8oXVy0GLWJ4=
Received: by 10.42.1.9 with SMTP id 9mr14441366ice.52.1286369210926; Wed, 06
 Oct 2010 05:46:50 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 05:46:50 -0700 (PDT)
In-Reply-To: <1286365670193-5606731.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158284>

On Wed, Oct 6, 2010 at 11:47, cdossantos
<claudia.dossantos@ricoh-europe.com> wrote:

> Any ideas?

Since you have problems when you invoke Git via Maven but not when you
invoke Git directly it would probably be better to ask these questions
on a forum for Maven.

You proably aren't going to find people here that know enough maven
internals offhand to know where it's screwing up its git invocations.
