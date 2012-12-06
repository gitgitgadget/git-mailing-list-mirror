From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull l10n updates for 1.8.1 round 2
Date: Thu, 6 Dec 2012 10:54:31 +0800
Message-ID: <CANYiYbGG8DeneCRyxyfVoZ+O2yBm9ywOGZwQMZC9=VYVN5Pf=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 03:54:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgRbs-0005dj-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 03:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab2LFCyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 21:54:32 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33031 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2LFCyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 21:54:32 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so9460127ieb.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 18:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=B5c1EU/UsBxTbBNU6Fnm0YDsszq06oDNLMj4rkkEYeQ=;
        b=vDFxZCkjxWzFhafhrXkNS77zdc/FktEJT5C+XEnykqzWsmWZtX4RfBwjSjZ5P3pvoi
         1f8laM7dUw5JXOaGJtjSZ2GJhOy6f+wElS7FxjtRg0Olk3Fk40DwK5jf3ra+eKb1XXT0
         25w6bnthBycjxJeQr2P6lKGxb53jO/N2BkzPlujimdFUD4xZe4ltwguyokwY3AyB09vp
         2Q+hyHLxiQ3jw7IXaHzX1WBWMdqPaeN2zipa/bb3PmMoiu6WrfFqjzv8FhZFB8iIVSR0
         Ukm4SicMyZc+EL7Jz8CY0kYtYxPzrlx74dyMn19sx0UtIY2DyMR8acsw+ArQV4x/7neT
         QHXg==
Received: by 10.42.215.10 with SMTP id hc10mr66337icb.19.1354762471610; Wed,
 05 Dec 2012 18:54:31 -0800 (PST)
Received: by 10.50.186.135 with HTTP; Wed, 5 Dec 2012 18:54:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211153>

Hi, Junio

The following changes since commit f94c3251e1400c3cf349f7f84fea4db66b540113:

  Update draft release notes to 1.8.1 (2012-11-29 13:57:09 -0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po master

for you to fetch changes up to 77cc392d6d60c5d22930174904adae182502b8a9:

  l10n: vi.po: update to git-v1.8.0.1-347-gf94c3 (2012-11-30 13:43:11 +0700)

----------------------------------------------------------------
Jiang Xin (1):
      l10n: Update git.pot (5 new, 1 removed messages)

Tran Ngoc Quan (1):
      l10n: vi.po: update to git-v1.8.0.1-347-gf94c3

 po/git.pot | 46 +++++++++++++++++++++++++++++++--------------
 po/vi.po   | 63 ++++++++++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 75 insertions(+), 34 deletions(-)

--
Jiang Xin
