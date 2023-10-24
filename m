Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A474134DE
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3pnZO3y"
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B2C90
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 00:48:04 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so3888516276.0
        for <git@vger.kernel.org>; Tue, 24 Oct 2023 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698133684; x=1698738484; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QyazRGKJgheIOhsWPRDtTns7UREcllUFWoZuZoWqwm4=;
        b=Y3pnZO3ym/EdAj0jBSsybW6m05HHZrBJ3Fq1reZ/WzUh+3zuxhdkXW/GTbVPbbtq9b
         wg4ZGxngDJAWSrLn6OSvfF81dW1VK1JvmKYbgQf33OVkvsOkbHR4zWAYgU6G4XE+tF9M
         Dr1YcoT5eveMelB/eTRjRRYw2Lxa/UyNtuaFYO2ISauQFDb93ecRH1bNSfy+S45ieoZP
         AtqNMjtTr6uEpLQoypnF+doOrETtyxRfFJR2rFtGQUSiFsMlxTgeUdagj7A+ky2jUQTJ
         xRh8Y27THlsT/QfmI5MYagE0/l/tElOfT4Dpsgjnw5BnjexcP/d/jd1WNH0UIDBTZ4SJ
         qe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698133684; x=1698738484;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyazRGKJgheIOhsWPRDtTns7UREcllUFWoZuZoWqwm4=;
        b=APUO8xHyKi2sJY6zjyZSA7jCwmvAcEWIzH6mhS1d21Oy8nH2oYqFMiisLrgw5kiRFu
         4EDsOWh9FgSoTtibNI/TYC43jYNf/1BLG2ktswbxmwxuYSzH1SJRlP9oxXwQZgF8BQ2t
         rpmNKAYeGCLD1FcHO1VdweMc32ZZ6HvSusMaMm+v33/3BcU/yKsI8TxRnD4X10scCFKE
         bs2kfO1QAVGDH0sB/GX4lfsrNFQNzJl1roMTW9Kc83fYtufV9Rv34aZlzCwrgsUPBsdP
         Xr67BfhcpNM2L4exZxwqoYwzxRnaYIHjqhzqJopL7w+AiDGvv/E8o8BrDHMoKLZI8r7C
         EYbg==
X-Gm-Message-State: AOJu0YzIryDGuMBLgBSAzpI44vctWY0wUHI8DloOOhMu/wmSViZ8U3IM
	pfAXOdaAhHubaXsZDvW+IchpGdfM5gSDOYyPKzQzu+T1OmBX54o=
X-Google-Smtp-Source: AGHT+IGYgmEzphZLQArXC1+UdwuGgCRnogjhl6Z5EvOObcThtJljpMHIUP4Cm2Jd4NdEKE+2SmzwAiFno3dSKAPQ+tE=
X-Received: by 2002:a25:943:0:b0:d9a:4ae7:ba2c with SMTP id
 u3-20020a250943000000b00d9a4ae7ba2cmr10229869ybm.22.1698133683797; Tue, 24
 Oct 2023 00:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Tue, 24 Oct 2023 08:47:34 +0100
Message-ID: <CACS=G2yJa3xvCPN6bqsa4+vSkwsdUouhqNvuH6y_CC2cJ0YSmQ@mail.gmail.com>
Subject: [OUTREACHY] Final Application For Git Internshhip
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm Ibe Naomi Amarachi,I'm a Nigerian and I currently live in
Lagos,Nigeria. I'm a graduate of the African Leadership Xcelerator
Software Engineering program (ALX SE), with specialization in backend
web development and I'm applying for the "Moving Existing Tests to a
Unit Testing Framework" project

Some of my projects that involve working with Shell,C and Git can be found here:

https://github.com/Amarajah/alx-system_engineering-devops

https://github.com/Amarajah/alx-low_level_programming

Git has been a part of my software engineering journey from day one
and it's allowed me to collaborate with peers and also keep track of
my personal projects. Currently Git uses end-to-end tests for error
conditions that could easily be captured by unit tests, the project is
aimed at turning end-to-end tests to unit tests, and I'd love to be a
part of it

My microproject contribution is here:

https://public-inbox.org/git/20231009011652.1791-1-naomi.ibeh69@gmail.com/T/#u

And here is my updated contribution link after review by the Git community:

https://public-inbox.org/git/xmqqttqox5cp.fsf@gitster.g/T/#u

Below is my project timeline:
(Of course I'd be very much willing to work with the community and
mentors to edit it so it perfectly meets up to the community's
expectations)

October 2, 2023 - October 30, 2023

Familiarizing myself with the community , mailing list and
contributing my microproject

November 20, 2023 - December 4, 2023

Familiarizing myself with the already existing tests and also the
chosen unit test framework

Do more research on the internship projects and find better ways to
get it done in harmony with coding guidelines and community
requirements

December 4, 2023 - December 31, 2023

First document the initial state of the test files, then make sure all
test files conform to coding guidelines down to the tiniest details
(e.g git/t/helper/test-write-cache.c and git/t/helper/test-advise.c
have die() messages which do not conform to coding guidelines)

January 2, 2024 - January 31, 2024

Run the tests and verify they still work as originally intended

Begin migrations of test files

Test migrated files and make necessary changes based on feedback
received from teammates and mentors

February 1, 2024 - March 1, 2024

Continue testing migrated files and making necessary changes based on
feedback received from teammates and mentors

Document each step and request for reviews from teammates and mentors

Tidy up the project,make sure all necessary files are migrated, they
all work as intended, they are well documented and that there are no
conflicts
