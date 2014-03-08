From: Guillaume Gelin <contact@ramnes.eu>
Subject: git 1.9.0 segfault
Date: Sat, 8 Mar 2014 16:23:43 +0000
Message-ID: <CAPn4x+oTTzYMSFzqUmJ8tOO0DdqR+HJJdoeXFZxhABu6B=QmBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 17:24:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMK2l-0007iZ-PY
	for gcvg-git-2@plane.gmane.org; Sat, 08 Mar 2014 17:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaCHQYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 11:24:07 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:58453 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaCHQYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 11:24:06 -0500
Received: by mail-wg0-f50.google.com with SMTP id x13so6712723wgg.9
        for <git@vger.kernel.org>; Sat, 08 Mar 2014 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=AlJjByA09TMCnvN5SG5JHH6Dx1vyVBJNnY9BQXKjyUg=;
        b=Nj4uFUg5rwM7Al4/BN5tz0XaclwS1kOWSi/N5u03IAaOLsEqNxT0Arjn8yQFmzDtVv
         U9qnWHkePbKZRWXOyTwJhgXVd1/uFw4Ff/Hfiha7iQguQsCp2vRhiKIGdZLc2GGPOvkR
         u/pYYYg3JF/8xzdvfgjuyA5B0R2u1FDvGC3+aGDYjdwZNyc2qYXIQ/RnVm+xbrRaPGxK
         lSvKV8g/FSXclZP5/dVwZQu2Y3KzqAdp62k1PSroDPxtN2nUnEW6NcKpRk6frc65sjE9
         9tq9CEoe9+sBes+54aGF+3BZE9NBFK/SHX1PY4UvrwZ42/ZUq/e4XeTS6jda9eONwkdA
         CFcQ==
X-Received: by 10.180.94.196 with SMTP id de4mr2099203wib.16.1394295844061;
 Sat, 08 Mar 2014 08:24:04 -0800 (PST)
Received: by 10.216.191.200 with HTTP; Sat, 8 Mar 2014 08:23:43 -0800 (PST)
X-Google-Sender-Auth: fQyaHT0_nuAOcCFHR5oEWVVrAFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243675>

Hi,

http://pastebin.com/Np7L54ar

Cheers,

-- 
Guillaume Gelin
